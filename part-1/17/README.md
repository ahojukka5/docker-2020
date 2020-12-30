# Exercise 1.17

CLI-tools combines a lot of different cli tools for a single docker container.
Among that, a very important tool `howdoi` is included to give further
instructions how things are done.

Usage:

Add this to your `.bashrc`:

```bash
alias cli='docker run --rm -it --name cli-tools ahojukka5/cli-tools:latest'
```

After that, try for example `howdoi`:

```text
00:29 $ cli howdoi write hello world in C++
```

Response should be:

```text
#include <iostream.h>      // note the .h suffix
// using namespace std;    // Turbo C++ doesn't implement namespaces

int main()
{
    cout << "Hello, World!";
    return 0;
}
```

Among that, a lot of different cli tools are included:

- Heroku CLI (`cli heroku --help`)
- IBM Cloud CLI (`cli ibmcloud --help`)
- CloudFlare CLI (`cli cfcli --help`)
- DigitalOcean CLI (`cli doctl --help`)
- GitHub CLI (`cli gh --help`)
- Travis-CI CLI (`cli travis --help`)
- Amazon ElasticBeans CLI (`cli eb --help`)
- Amazon Amplify CLI (`cli amplify --help`)

Other things installed (needed to install all cli tools)

- gcc
- python3
- ruby
- node

Project is hosted on GitHub: <https://github.com/ahojukka5/cli-tools>

Automatic deployment is done to Docker-hub using Github actions:
<https://hub.docker.com/repository/docker/ahojukka5/cli-tools>
