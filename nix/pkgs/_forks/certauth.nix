{
  lib,
  buildPythonPackage,
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

  src = fetchGit {
    url = "https://github.com/theCapypara/certauth.git";
    rev = "e7eb7f3063f3df0198ef0a5b7cac13a28ef64f26";
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
