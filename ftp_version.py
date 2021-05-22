import requests
# find and save the current Github release
html = str(
    requests.get('https://gitlab.com/gitlab-org/ci-cd/docker-machine/-/raw/master/version/version.go')
    .content)
index = html.find('Version = ')
github_version = html[index + 11:index + 27].replace('<', '').replace(' ', '').replace('\\', '')
file = open('github_version.txt', 'w')
file.writelines(github_version)
file.close()

# find and save the current version on FTP server
html = str(
    requests.get(
        'https://oplab9.parqtec.unicamp.br/pub/ppc64el/docker-machine/'
    ).content)
index = html.rfind('docker-machine-v')
ftp_version = html[index + 16:index + 32].replace('<', '').replace(' ', '').replace('\\', '')
file = open('ftp_version.txt', 'w')
file.writelines(ftp_version)
file.close()

# find and save the oldest version on FTP server
index = html.find('docker-machine-v')
delete = html[index + 16:index + 32].replace('<', '').replace(' ', '').replace('\\', '')
file = open('delete_version.txt', 'w')
file.writelines(delete)
file.close()
