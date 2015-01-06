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

This is useful if, for example, you work in an environment where a security team is interested
in using Puppet for Tripwire / Samhain / Nessus style functionality but does not want to
actively manage the files in question, and simply be alerted using Puppet's reporting mechanism
if there has been drift.

##Setup

###What puppet_audit affects

* Each file, symlink, or directory you want to be informed about needs to have its "correct"
  properties asserted in the instantiation of its defined type
* Additionally, for files, the md5 sum needs to be asserted using the `$fileMD5` attribute.
  You can generate this from the system using the `md5sum(1)` command on Linux systems,
  the `md5` command on Mac OS X, or `openssl md5 < *(filename)*` on systems which do not
  have either of these utilities installed.

###Beginning with puppet_audit

* hiera instructions here?

##Usage

* using profiles here?
* using tags / tagmail?

##Limitations

* The files, links and directories you create using puppet_audit cannot *also* be managed
  in other parts of your Puppet configuration as regular resources; doing so will cause 
  a "duplicate resource" error.

##Development

Contributions welcome!

##Release Notes/Contributors/Etc **Optional**

This module expands and abstracts the ["Alternate Compliance Workflow" outlined in the 
Puppet Enterprise documentation](https://docs.puppetlabs.com/pe/latest/compliance_alt.html).
