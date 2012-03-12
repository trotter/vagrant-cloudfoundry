Description
===========

Vagrant CloudFoundry provides a Vagrantfile, necessary Veewee
files, and the requisite cookbooks (as submodules) for booting a
 VirtualBox VM running a full CloudFoundry instance. Unfortunately,
Virtualbox is not _always_ the fastest, so this repository also contains
a node.json and solo.rb necessary for running the CloudFoundry cookbooks
against an existing machine, such as one that has been created with
VMware Fusion.

Requirements
============

To use this repository, you need Ruby installed on your local machine.
This code has only been tested with Ruby 1.9.2, but it _may_ work on
1.8.7 as well. If you're planning on running VMs locally, you'll also need Virtualbox, VMware Fusion, or Parallels.

Usage
=====

There are two ways to use this repository. The first is to use Vagrant
and Veewee to completely build a VM from scratch and install
CloudFoundry on it. The second is to use knife-solo against an existing
VM.

With either approach, you'll first need the required Ruby Gems:

    bundle install

You'll also need to download all the required cookbooks and their
dependencies using librarian:

    librarian-chef install

If you make any changes to the cookbooks in cookbooks-sources, you'll
need to run `librarian-chef install` again in order to pick them up.

Vagrant
-------

First, use veewee to create the Virtualbox image:

    cd veewee
    vagrant basebox build ubuntu-10.04.2-cloud-foundry
    cd -

Next, run Vagrant:

    vagrant up

This will start a VM running Ubuntu 10.04, install CloudFoundry on it,
and start all services. Unlike below, we do not need to forward any
ports, because Vagrant will do this for us automatically.

If you update any cookbooks and want to update your vm, run

    vagrant provision

For more Vagrant commands, see the [Vagrant docs](http://vagrantup.com).

Knife Solo
----------

If you're not using Vagrant for your virtualization, you can use Knife
Solo to provision an existing VM. First, you'll want to download the
Ubuntu 10.04 iso and install it. Next, you'll bootstrap the box to be
able to run chef and use knife solo to run the cookbooks against it.

    knife prepare <user>@<VM IP address>
    knife cook user@vm-ip nodes/all-in-one.json

In order to access your CloudFoundry Instance, you'll need to setup an
ssh tunnel to forward port 80 from your VM to a local port:

    sudo ssh -L 8080:<VM IP address>:80 <user>@<VM IP address> -N &

Connecting To Your CloudFoundry Instance
----------------------------------------

To access your CloudFoundry Instance, you need to register your vmc
target your vmc client at `api.vcap.me:8080`. This will work because
VMware has purchased the `vcap.me` domain and pointed it at `127.0.0.1`.
The port of `8080` on the end is the port that we have forwarded from
our VM.

    vmc target api.vcap.me:8080
    vmc register   # Provide a username and password
    vmc apps       # You will have no apps
    vmc runtimes   # You'll see a list of available runtimes
    vmc frameworks # You'll see a list of available frameworks
    vmc services   # You'll see a list of available services

For more information on the vmc client, run `vmc help`.

License and Author
==================

Author:: Trotter Cashion (<cashion@gmail.com>)

Copyright (c) 2012 Trotter Cashion

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
