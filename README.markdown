####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with puppet_audit](#setup)
    * [What puppet_audit affects](#what-puppet_audit-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with puppet_audit](#beginning-with-puppet_audit)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

This module allows you to be *alerted* of changes to files and directories that you need
to audit but do not necessarily want to *change*.

##Module Description

Puppet has had Tripwire-style functionality for a while, but the previous implementation
(using the `audit` metaparameter in conjunction with the `puppet inspect` subcommend) had
some significant drawbacks. This module provides similar benefits to the `puppet inspect`
method, but does so using regular Puppet resources and reports, so its provides a clean,
supported workflow.

It implements a few defined types, `puppet_audit::directory`, `puppet_audit::link`, and `puppet_audit::file`,
which will check (but not manage) properties that you assert about the each instantiation
of the type. Differences between the desired state and the actual state on the system will
trigger a report entry describing the difference, but because each resource has the `noop`
metaparameter set to `true`, will *not* change the state of the filesystem.

This is useful if, for example, you work in an environment where a security team is interested in using Puppet for Tripwire / Samhain / Nessus style functionality but does not want to actively manage the files in question, and simply be alerted using Puppet's reporting mechanism if there has been drift.

The puppet_audit module packages 3 defined resource types to check the presence / integrity of sensitive files, directories and symbolic links.


A standalone module which consumes hiera hash data pertinent to files, directories and symbolic links in the following example form:

##Setup

 Install the module from the forge and classify appropriate nodes with a profile class i.e.
<pre>
 class profile::puppet_audit {
   include puppet_audit

  # Setup local hash variables pulling data from Hiera hashes.
   $security_files_hash = hiera_hash('profile::puppet_audit_files',{})
   $security_directories_hash = hiera_hash('profile::puppet_audit_directories',{})
   $security_links_hash = hiera_hash('profile::puppet_audit_links',{})
  
  # Check files, directories, and links using create resources function.
  
   create_resources('puppet_audit::file', $security_files_hash)
   create_resources('puppet_audit::directory', $security_directories_hash)
   create_resources('puppet_audit::link', $security_links_hash)
  } 
</pre>

Hiera data for example usage:
<pre>
  ---
  'profile::puppet_audit_files':
    '/etc/passwd':
      checksum_value: '0c4305ed79b2292299b00ebcb691a0e4'
      group: '0'
      mode: '644'
      owner: '0'
    '/etc/group':
      checksum_value: '{md5}51c9981096429f8e37696806c7b0050f'
      group: '0'
      mode: '644'
      owner: '0'
  'profile::puppet_audit_directories':
    '/etc/rc.d':
      group: '0'
      owner: '0'
      mode: '755'
    '/etc/xinetd.d':
      group: '0'
      owner: '0'
      mode: '755'
  'profile::puppet_audit_links':
    '/etc/grub.conf':
      group: '0'
      owner: '0'
      mode: '777'
      target: '../boot/grub/grub.conf'
</pre>


###What puppet_audit affects

* Each file, symlink, or directory you want to be informed about needs to have its "correct"
  properties asserted in the instantiation of its defined type
* Additionally, for files, the md5 sum needs to be asserted using the `$fileMD5` attribute.
  You can generate this from the system using the `md5sum(1)` command on Linux systems,
  the `md5` command on Mac OS X, or `openssl md5 < *(filename)*` on systems which do not
  have either of these utilities installed.


* using tags / tagmail?



###Setup Requirements **OPTIONAL**

 None.

###Beginning with puppet_audit

This module expands and abstracts the ["Alternate Compliance Workflow" origionally outlined in the 
Puppet Enterprise documentation](https://puppet.com/docs/pe/2017.2/compliance_alt.html).

---
layout: default
title: "Compliance alternate workflow"
canonical: "/pe/latest/compliance_alt.html"
toc: false
---


This page describes an alternate workflow which will allow you to maintain baseline states and audit changes in your Puppet-controlled infrastructure.


#### Workflow in brief

 - _Instead of writing audit manifests:_ Write manifests that describe the desired baseline state(s). This is identical to writing Puppet manifests to _manage_ systems: you use the resource declaration syntax to describe the desired state of each significant resource.
 - _Instead of running Puppet agent in its default mode:_ Make it sync the significant resources in **no-op mode,** which can be done for the entire Puppet run, or per-resource. (See below.) This causes Puppet to detect changes and _simulate_ changes, without automatically enforcing the desired state.
 - _In the console:_ Look for "pending" events and node status. "Pending" is how the console represents detected differences and simulated changes.

#### Controlling your manifests

 As part of a solid change control process, you should be maintaining your Puppet manifests in a version control system like Git. A well-designed branch structure in version control will allow changes to your manifests to be tracked, controlled, and audited.

#### No-op features

 Puppet resources or catalogs can be marked as "no-op" before they are applied by the agent nodes. This means that the user describes a desired state for the resource, and Puppet will detect and report any divergence from this desired state. Puppet will report what _should_ change to bring the resource into the desired state, but it will not _make_ those changes automatically.

 * To set an individual resource as no-op, set [the `noop` metaparameter]({{puppet}}/metaparameter.html#noop) to `true`.

         file {'/etc/sudoers':
           owner => root,
           group => root,
           mode  => 0600,
           noop  => true,
         }

     This allows you to mix enforced resources and no-op resources in the same Puppet run.
 * To do an entire Puppet run in no-op, set [the `noop` setting]({{puppet}}/configuration.html#no-op) to `true`. This can be done in the `[agent]` block of puppet.conf, or as a `--noop` command-line flag. If you are running Puppet agent in the default daemon mode, you would set no-op in puppet.conf.

#### In the console

 In the console, you can locate the changes Puppet has detected by looking for "pending" nodes, reports, and events. A "pending" status means Puppet has detected a change and simulated a fix, but has not automatically managed the resource.

 You can find a pending status in the following places:

 * The node summary, which lists the number of nodes on which changes were detected.

 * The list of recent reports, which uses an orange asterisk to show reports in which changes were detected.

 * The _log_ and _events_ tabs of any report containing pending events. These tabs will show you what changes were detected, and how they differ from the desired system state described in your manifests.

#### After detection

 When a Puppet node reports no-op events, this means someone has made changes to a no-op resource that has a desired state desribed. Generally, this either means an unauthorized change has been made, or an authorized change was made but the manifests have not yet been updated to contain the change. You will need to either:

 * Revert the system to the desired state (possibly by running Puppet agent with `--no-noop`).
 * Edit your manifests to contain the new desired state, and check the changed manifests into version control.

#### Before detection

 However, your admins should generally be changing the manifests before making authorized changes. This serves as documentation of the change's approval.

#### Summary

 In this alternate workflow, you are essentially still maintaining baselines of your systems' desired states. However, instead of maintaining an _abstract_ baseline by approving changes in the console, you are maintaining _concrete_ baselines in readable Puppet code, which can be audited via version control records.


##Usage

puppet_audit examples/profiles shows desired usage.
##Reference

Please see: https://docs.puppetlabs.com/hiera/1/lookup_types.html for information on encapsulating data in hiera hashes.

##Limitations

* The files, links and directories you create using puppet_audit cannot *also* be managed
  in other parts of your Puppet configuration as regular resources; doing so will cause 
  a "duplicate resource" error.
* This module has been tested on Darwin [OSX] and Centos 6.5. Although it simply leverages Puppet resources in a known pattern.

##Development

Contributions welcome!
=======
 Only the list of files, directories and symlinks specified in the appropriate hiera hashes.


##Release Notes/Contributors/Etc 

abuxton 
dbmoore
trlinkin

