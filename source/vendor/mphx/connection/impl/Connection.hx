package vendor.mphx.connection.impl ;

import haxe.io.Eof;
import haxe.io.Input;
import haxe.io.Bytes;
import vendor.mphx.serialization.impl.HaxeSerializer;
import vendor.mphx.serialization.ISerializer;
import vendor.mphx.connection.IConnection;
import vendor.mphx.server.IServer;
import vendor.mphx.server.room.Room;
import vendor.mphx.utils.event.impl.ServerEventManager;
import haxe.io.Error;
import vendor.mphx.utils.Log;

class Connection implements IConnection
{
	private var server:IServer;
	public var cnx:NetSock;
	public var serializer:ISerializer;
	public var events:ServerEventManager;
	public var room:Room = null;
	public var data:Dynamic;
		
	public function new ()
	{
		
	}

	public function clone() : IConnection
	{
		return new Connection();
	}

	public function configure(_events : ServerEventManager, _server:IServer, _serializer : ISerializer = null) : Void
	{
		events = _events;
		server = _server;

		if (_serializer == null)
			this.serializer = new HaxeSerializer();
		else
			serializer = _serializer;
	}

	public function isConnected():Bool { return cnx != null && cnx.isOpen(); }
	public function getContext() :NetSock {return cnx;}

	public function putInRoom (newRoom:vendor.mphx.server.room.Room)
	{
		if (newRoom.full){
			return false;
		}
		if (room != null){
			room.onLeave(this);
		}

		room = newRoom;
		newRoom.onJoin(this);

		return true;
	}

	public function onAccept(cnx:NetSock) : Void
	{
		this.cnx = cnx;

		if (server.onConnectionAccepted != null)
			server.onConnectionAccepted("accept : " + this.getContext().peerToString(), this);
	}

	//difference with onAccept ?
	public function onConnect(cnx:NetSock) : Void
	{
		this.cnx = cnx;

		//if (server.onConnectionAccepted != null)
			//server.onConnectionAccepted("connect : " + this.getContext().peerToString(), this);
	}

	public function loseConnection(?reason:String)
	{
		//trace("Client disconnected with code: " + reason);
		
		if (server.onConnectionClose != null)
			server.onConnectionClose(reason, this);

		if (room != null){
			room.onLeave(this);
		}

		if (cnx != null)
		{
			cnx.clean();
			this.cnx = null;
		}
	}

	public function send(event:String, ?data:Dynamic):Bool
	{
		var object = {
			t: event,
			data:data
		}

		try
		{
			var serialiseObject = serializer.serialize(object);
			var result = cnx.writeBytes(Bytes.ofString(serialiseObject + "\r\n"));
			return result;
		}
		catch (e:Dynamic)
		{
			// cannot send data to this user.
			return false;
		}
		
	}

	public function recieve(line:String)
	{
		var msg = serializer.deserialize(line);
		events.callEvent(msg.t,msg.data,this);
	}

	public function dataReceived(input:Input):Void
	{
		//Convert Input to string then process.
		var line = "";
		var done : Bool = false;
		var data : String = "";
		while (!done)
		{
			try
			{
				data = input.readLine();

				try
				{
					recieve(data);
				}
				/*catch (e:haxe.Exception)
				{
					Log.message(DebugLevel.Errors | DebugLevel.Networking,"Can't use data: " + data + " because: "+e.details() );
					throw Error.Blocked;
				}*/
				catch (e:Dynamic)
				{
					if (data == "" || Reg._usernameLastLogged == "") {}
					else
					{
						
						if (Reg._usernameLastLogged == null)
							Log.message(DebugLevel.Errors | DebugLevel.Networking,"User tried to login with unsupported characters.");
						else
						{
							if (e.substr(0, 12) != "Invalid char")
								Log.message(DebugLevel.Errors | DebugLevel.Networking,"Can't use data: " + data + " because: "+e + ": User:" + Reg._usernameLastLogged);
						}	
						throw Error.Blocked;
					}
				}
			}
			catch (e : Eof)
			{
				done = true;
			}
			catch (e : Error)
			{
				//nothing special, continue.
			}
			catch (e:Dynamic)
			{
				Log.message(DebugLevel.Errors | DebugLevel.Networking,"Data can't be read because: "+e+". Skipping.");
			}
		}
	}
}
