{
  lib,
  aiohttp,
  buildPythonPackage,
  coreutils,
  fetchFromGitHub,
  google-auth,
  google-auth-oauthlib,
  google-cloud-pubsub,
  mashumaro,
  pytest-aiohttp,
  pytest-asyncio,
  pytestCheckHook,
  pythonOlder,
  requests-oauthlib,
  setuptools,
}:

buildPythonPackage rec {
  pname = "google-nest-sdm";
  version = "6.1.3";
  pyproject = true;

  disabled = pythonOlder "3.10";

  src = fetchFromGitHub {
    owner = "allenporter";
    repo = "python-google-nest-sdm";
    rev = "refs/tags/${version}";
    hash = "sha256-X/jiers05zNAEUau6SVKGyyIx9HCs7yI0HsuZ7/tXfo=";
  };

  build-system = [ setuptools ];

  dependencies = [
    aiohttp
    google-auth
    google-auth-oauthlib
    google-cloud-pubsub
    mashumaro
    requests-oauthlib
  ];

  __darwinAllowLocalNetworking = true;

  nativeCheckInputs = [
    coreutils
    pytest-aiohttp
    pytest-asyncio
    pytestCheckHook
  ];

  pythonImportsCheck = [ "google_nest_sdm" ];

  disabledTests = [
    "test_clip_preview_transcode"
    "test_event_manager_event_expiration_with_transcode"
  ];

  meta = with lib; {
    description = "Module for Google Nest Device Access using the Smart Device Management API";
    homepage = "https://github.com/allenporter/python-google-nest-sdm";
    changelog = "https://github.com/allenporter/python-google-nest-sdm/releases/tag/${version}";
    license = licenses.asl20;
    maintainers = with maintainers; [ fab ];
    mainProgram = "google_nest";
  };
}
