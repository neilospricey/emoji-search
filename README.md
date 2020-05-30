Emoji Search
---

This repo is forked off https://ahfarmer.github.io/emoji-search for demo purposes as I needed a test react website.

This repo is designed to work in tandem with this Ansible repo https://github.com/neilospricey/emoji-search-ansible.  I recommend you read this README and the other repo's README if you wish to follow it exactly (otherwise it can be used as a reference):

Prerequisites
---

- Server 1 (dev) - running Centos (Ansible and Jenkins installed)
- Server 2 (test) - running Centos

I used Virtual box to spin up two Centos instances for this purpose.

Jenkins
---

I've added a Jenkinsfile to the repo to define the build steps and used the 'Pipeline script from SCM' option so that it gets detected upon creation of the pipeline.

It's also worth mentioning that I've added the known_hosts and id_rsa files under /var/lib/jenkins/.ssh/ which are used when jenkins needs to communicate with other servers (for deployments).

Docker
---

There is also a Dockerfile and a docker-compose file in the repo.  Both work standalone but I've chosen to use the Dockerfile in the Jenkins build steps.

Overall Workflow
---

The Jenkins build does the following:

* installs npm dependencies
* runs npm tests
* builds and tags the docker container image
* deploys the container to the dev environment, which is defined in Ansible which asserts the following desired state on the server:
    * installs server dependencies
    * runs react app in docker container
* deploys the container to the test environment, which is defined in Ansible which asserts the desired state on the server using the same steps above. 