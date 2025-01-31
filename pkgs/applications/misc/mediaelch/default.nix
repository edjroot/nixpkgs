{ lib
, mkDerivation
, fetchFromGitHub
, qmake
, curl
, ffmpeg
, libmediainfo
, libzen
, qtbase
, qtdeclarative
, qtmultimedia
, qtsvg
, qttools
, quazip
}:

mkDerivation rec {
  pname = "mediaelch";
  version = "2.8.14";

  src = fetchFromGitHub {
    owner = "Komet";
    repo = "MediaElch";
    rev = "v${version}";
    sha256 = "sha256-yHThX5Xs+8SijNKgmg+4Mawbwi3zHA/DJQoIBy0Wchs=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ qmake qttools ];

  buildInputs = [ curl libmediainfo libzen ffmpeg qtbase qtdeclarative qtmultimedia qtsvg ];

  qmakeFlags = [
    "USE_EXTERN_QUAZIP=${quazip}/include/quazip5"
  ];

  postPatch = ''
    substituteInPlace MediaElch.pro --replace "/usr" "$out"
  '';

  meta = with lib; {
    homepage = "https://mediaelch.de/mediaelch/";
    description = "Media Manager for Kodi";
    license = licenses.lgpl3Only;
    maintainers = with maintainers; [ stunkymonkey ];
    platforms = platforms.linux;
  };
}
