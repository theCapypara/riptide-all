{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  pyopenssl,
  pytestCheckHook,
  pythonOlder,
}:

# XXX: Sets to a fork that doesn't use tldextract, since tldextract always tries to fetch files from the internet
# when starting, which is really annoying. We don't need the security features of tldextract here.
buildPythonPackage {
  pname = "certauth";
  version = "1.3.0";
  pyproject = true;

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "theCapypara";
    repo = "certauth";
    rev = "5fdc45c23e373228c5519a650ceba5d88b909cc7";
    hash = "sha256-INafbJ1UmjXaBw6J5oambwacny5yzukNRbGr30/xGYs=";
  };

  postPatch = ''
    substituteInPlace setup.py \
      --replace-fail "--cov certauth " ""
  '';

  nativeBuildInputs = [ setuptools ];

  propagatedBuildInputs = [ pyopenssl ];

  nativeCheckInputs = [ pytestCheckHook ];

  pythonImportsCheck = [ "certauth" ];

  disabledTests = [
    # https://github.com/ikreymer/certauth/issues/23
    "test_ca_cert_in_mem"
    "test_custom_not_before_not_after"
    # Tests want to download Public Suffix List
    "test_file_wildcard"
    "test_file_wildcard_subdomains"
    "test_in_mem_parent_wildcard_cert"
    "test_in_mem_parent_wildcard_cert_at_tld"
    "test_in_mem_parent_wildcard_cert_2"
  ];

  meta = with lib; {
    description = "Simple CertificateAuthority and host certificate creation, useful for man-in-the-middle HTTPS proxy";
    mainProgram = "certauth";
    homepage = "https://github.com/ikreymer/certauth";
    license = licenses.mit;
    maintainers = with maintainers; [ Luflosi ];
  };
}
