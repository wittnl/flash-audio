﻿package src {
	
	import flash.display.MovieClip;	
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.media.Sound;
	import flash.events.Event;
	
	public class FlashAudio extends MovieClip {
		
		protected var cache:Object = {};
		
		public function FlashAudio() {
			// constructor code
			this.init();
		}
		
		private function init():void {
			_setupExternalInterface();
		}
		
		private function _setupExternalInterface():void {
			if(ExternalInterface.available === true) {
				ExternalInterface.addCallback('playSound', playSound);
				ExternalInterface.addCallback('stopSound', stopSound);
				ExternalInterface.addCallback('ready', function() { return true; });
			}else{
				throw new Error("ExternalInterface unavailable, can't reach JavaScript!");
			}
		}
		
		private function _playAudio(e:Event):void {
			e.currentTarget.play();
		}
		
		private function _stopAudio():void {
			
		}

		
		public function playSound(url:String) {
			if(cache.hasOwnProperty(url)) {
				cache[url].play();
			}else{
				var sound:Sound = new Sound(new URLRequest(url));
				cache[url] = sound;				
				sound.addEventListener(Event.COMPLETE, _playAudio);
			}			
		}
		
		public function stopSound():void {
			for each(var url in cache) {
				cache[url].close();
			}
		}
		
	}
	
}
