enum YTMusicPageType {
  musicPageTypeAlbum,
  musicPageTypePlaylist,
  musicVideoTypeOmv;

  static string(YTMusicPageType pageType) {
    switch (pageType) {
      case YTMusicPageType.musicPageTypeAlbum:
        return 'MUSIC_PAGE_TYPE_ALBUM';
      case YTMusicPageType.musicPageTypePlaylist:
        return 'MUSIC_PAGE_TYPE_PLAYLIST';
      case YTMusicPageType.musicVideoTypeOmv:
        return 'MUSIC_VIDEO_TYPE_OMV';
    }
  }
}

const String feMusicHome = "FEmusic_home";
