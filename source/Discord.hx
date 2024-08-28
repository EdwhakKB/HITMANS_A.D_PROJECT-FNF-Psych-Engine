package;

import Sys.sleep;
import discord_rpc.DiscordRpc;
import lime.app.Application;

#if LUA_ALLOWED
import llua.Lua;
import llua.State;
#end

using StringTools;

class DiscordClient
{
	public static var isInitialized:Bool = false;
	private static var _defaultID:String = "1021986935792730273";
	public static var clientID(default, set):String = _defaultID;
	private static var _options:Dynamic = {
		details: "Desktop",
		state: null,
		largeImageKey: 'icon',
		largeImageText: "HITMANS A.D",
		smallImageKey : null,
		startTimestamp : null,
		endTimestamp : null
	};
	public function new()
	{
		trace("Discord Client starting...");
		DiscordRpc.start({
			clientID: clientID,
			onReady: onReady,
			onError: onError,
			onDisconnected: onDisconnected
		});
		trace("Discord Client started.");

		while (true)
		{
			DiscordRpc.process();
			sleep(2);
			//trace("Discord Client Update");
		}

		DiscordRpc.shutdown();
	}
	
	public static function check()
		{
			start();
		}
		
	public static function start()
		{
			if (!isInitialized) {
				initialize();
				Application.current.window.onClose.add(function() {
					shutdown();
				});
			}
		}

	public static function shutdown()
	{
		DiscordRpc.shutdown();
	}
	
	static function onReady()
	{
		DiscordRpc.presence(_options);
	}

	private static function set_clientID(newID:String)
		{
			var change:Bool = (clientID != newID);
			clientID = newID;
	
			if(change && isInitialized)
			{
				shutdown();
				isInitialized = false;
				start();
				DiscordRpc.process();
			}
			return newID;
		}

	static function onError(_code:Int, _message:String)
	{
		trace('Error! $_code : $_message');
	}

	static function onDisconnected(_code:Int, _message:String)
	{
		trace('Disconnected! $_code : $_message');
	}

	public static function initialize()
	{
		var DiscordDaemon = sys.thread.Thread.create(() ->
		{
			new DiscordClient();
		});
		trace("Discord Client initialized");
		isInitialized = true;
	}

	public static function changePresence(details:String, state:Null<String>, ?smallImageKey : String, ?hasStartTimestamp : Bool, ?endTimestamp: Float)
	{
		var startTimestamp:Float = 0;
		if (hasStartTimestamp) startTimestamp = Date.now().getTime();
		if (endTimestamp > 0) endTimestamp = startTimestamp + endTimestamp;

		_options.details = ClientPrefs.discordRPC ? details : "CENSORED ";
		_options.state = ClientPrefs.discordRPC ? state : "NO LEAKS HERE";
		_options.largeImageKey = 'icon';
		_options.largeImageText = "Hitmans Version: " + MainMenuState.psychEngineVersion;
		_options.smallImageKey = smallImageKey;
		// Obtained times are in milliseconds so they are divided so Discord can use it
		_options.startTimestamp = Std.int(startTimestamp / 1000);
		_options.endTimestamp = Std.int(endTimestamp / 1000);
		DiscordRpc.presence(_options);

		//trace('Discord RPC Updated. Arguments: $details, $state, $smallImageKey, $hasStartTimestamp, $endTimestamp');
	}

	public static function resetClientID()
		clientID = _defaultID;

	#if LUA_ALLOWED
	public static function addLuaCallbacks(lua:State) {
		Lua_helper.add_callback(lua, "changePresence", function(details:String, state:Null<String>, ?smallImageKey:String, ?hasStartTimestamp:Bool, ?endTimestamp:Float) {
			changePresence(details, state, smallImageKey, hasStartTimestamp, endTimestamp);
		});
		Lua_helper.add_callback(lua, "changeDiscordClientID", function(?newID:String = null) {
			if(newID == null) newID = _defaultID;
			clientID = newID;
		});
	}
	#end
}
