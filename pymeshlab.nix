{
  stdenv,
  fetchFromGitHub,
  lib,
  cmake,
  meshlab,
  libGL,
  qtbase,
  wrapQtAppsHook,
  python3Packages,
  glew,
  eigen,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "pymeshlab";
  version = "2023.12.post1";

  src = fetchFromGitHub {
    owner = "cnr-isti-vclab";
    repo = finalAttrs.pname;
    rev = "v${finalAttrs.version}";
    hash = "sha256-/mJJvfX9m9GFcKfShcIBacOgAMTBvvZNqj7RSNDmxT4=";
  };

  buildInputs = [
    qtbase
    libGL
    glew
    eigen
  ];

  nativeBuildInputs = [
    cmake
    wrapQtAppsHook
    python3Packages.pybind11
  ];

  propagatedBuildInputs = [
    meshlab
  ];

  #cmakeFlags = [
    #"-DDESIRED_QT_VERSION=5"
    #"-DOpenGL_GL_PREFERENCE=GLVND"
  #];

  postPatch = ''
    substituteInPlace src/CMakeLists.txt \
      --replace-fail "add_subdirectory(meshlab)" ""
    substituteInPlace src/pymeshlab/CMakeLists.txt \
      --replace-warn "add_subdirectory(pybind11)" "find_package(pybind11 REQUIRED)"
  '';

  meta = with lib; {
    homepage = "https://github.com/cnr-isti-vclab/PyMeshLab";
    license = licenses.gpl3;
    maintainers = with maintainers; [ nim65s ];
  };
})
