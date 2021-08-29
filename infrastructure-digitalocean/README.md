# Infrastructure for rails apps

## Usage instructions

1. Create account on [Digital Ocean](https://m.do.co/c/cfc852e7f0e6)
2. Install [Ansible](https://www.ansible.com/)

``` bash
$ brew install ansible
```

3. Install [Terraform](https://www.terraform.io/)

``` bash
$ brew install terraform
```

4. Add to your shell configuration file (`.zshrc` or `.bashrc`) following line with DO personal access token and domain

``` bash
export DO_PAT="your_personal_access_token"
export DO_DOMAIN_NAME="your_domain"
export DO_PRIVATE_KEY="private_key_location"
```

alternatively you can configure script in your `.env` file and then exec

``` bash
$ source .env
```

5. Copy `infrastructure-digitalocean` folder to appropriate location

6. Initialize terraform

``` bash
$ terraform init
```

7. Run terraform plan command

``` bash
$ terraform plan -var "do_token=${DO_PAT}" -var "domain_name=${DO_DOMAIN_NAME}"
```

8. Then run terraform apply command

``` bash
$ terraform apply -var "do_token=${DO_PAT}" -var "domain_name=${DO_DOMAIN_NAME}" -var "private_key=${DO_PRIVATE_KEY}"
```

9. You can also destroy created resources 

``` bash
$ terraform destroy -var "do_token=${DO_PAT}" -var "domain_name=${DO_DOMAIN_NAME}"
```

## What's inside
## Todo

## Known issues

nothing

## Contributing [![PRs welcome](https://img.shields.io/badge/PRs-welcome-orange.svg?style=flat-square)](https://github.com/alec-c4/kickstart/issues)

For bug fixes, documentation changes, and features:

1. [Fork it](./fork)
1. Create your feature branch (`git checkout -b my-new-feature`)
1. Commit your changes (`git commit -am 'Add some feature'`)
1. Push to the branch (`git push origin my-new-feature`)
1. Create a new Pull Request

For larger new features: Do everything as above, but first also make contact with the project maintainers to be sure your change fits with the project direction and you won't be wasting effort going in the wrong direction.