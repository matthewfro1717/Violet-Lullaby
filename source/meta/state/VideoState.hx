package meta.state;

import meta.MusicBeat.MusicBeatState;
import sys.FileSystem;
import vlc.MP4Handler;

class VideoState extends MusicBeatState
{
	public static var videoName:String;

	override public function create()
	{
		super.create();

		#if VIDEOS_ALLOWED
		var filepath:String = SUtil.getPath() + Paths.video(videoName);
		if (!FileSystem.exists(filepath))
		{
			close();
			return;
		}

		var video:MP4Handler = new MP4Handler();
		video.playVideo(filepath);
		video.finishCallback = function()
		{
			close();
			return;
		}
		#else
		close();
		return;
		#end
	}

	public function close()
		Main.switchState(this, new PlayState());
}
