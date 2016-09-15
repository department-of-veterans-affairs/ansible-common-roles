This is a set of production-ready [Ansible](http://docs.ansible.com/) roles that automate:
* The *configuration* of a Ruby on Rails application (see the [roadrunner](roadrunner) role)
* The *deployment* of an application to an AWS region (see the [deploy-to-aws playbook](deploy-to-aws.yml) and [roadrunner-devops](roadrunner-devops) role).
 
These roles are generic enough that they could be repurposed to deploy *any* application, not just RoR apps.

## How to use
1. Add this repository as a [submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules): `git submodule add https://github.com/department-of-veterans-affairs/ansible-common-roles common-roles`
1. Modify `ansible.cfg` to include `roles_path = common-roles`

Check out https://github.com/department-of-veterans-affairs/roadrunner-devops to see these roles applied to a simple RoR application.
