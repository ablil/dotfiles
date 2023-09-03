# Global githook

To setup git hooks globally accross all repositories, do the following:

1. create `$HOME/.git-templates/hooks` directory and move all your hooks there
2. configure git init template dir `git config --gloabl init.templatedir ~/.git-templates`
3. re-init existing git repositories to apply changes `git init`

*Git copies everyhing inside init.templatedir to .git directory when init a new repo*
