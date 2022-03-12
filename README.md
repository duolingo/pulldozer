# Pulldozer

Pulldozer is a simple CLI tool for batch editing multiple GitHub repos.

You give Pulldozer a transformation script and it spits out pull requests. There are no other side effects - your existing local repos will remain untouched.

## Usage

Clone this repo onto any Unix machine that has [`curl`](https://brewinstall.org/install-curl-on-mac-with-brew/). Set your `GITHUB_TOKEN` environment variable to an [access token](https://github.com/settings/tokens) with `repo` scope and [SSO enabled](https://docs.github.com/en/github/authenticating-to-github/authorizing-a-personal-access-token-for-use-with-saml-single-sign-on).

To perform a batch edit:

1.  Specify your desired `COMMIT_MESSAGE` string, `transform` function, and `REPOS` list in a new shell script:

    ```sh
    COMMIT_MESSAGE='Fix "langauge" typos'

    transform() {
      # Your arbitrary shell commands go here. GitHub org name and repo name are
      # passed into this `transform` function as vars $1 and $2, respectively.
      echo "Repo $2 is being edited via Pulldozer!" >> README.md

      # Pulldozer provides a `replace_all` helper function for replacing text
      # across all repo files. It's basically glorified sed.
      replace_all 'langauge' 'language'

      # Advanced `replace_all` example: regex, capture grouping, multi-line
      # matching, and file path filtering
      replace_all '(\nprotobuf==)\S+' '\13.19.4' 'requirements\.(in|txt)$'
    }

    REPOS='
    artnc/dotfiles
    duolingo/halflife-regression
    duolingo/rtl-viewpager
    '

    # Optional: Markdown to include in pull request descriptions
    DESCRIPTION='[Correct spelling](https://en.wiktionary.org/wiki/language)'
    ```

    <details><summary>Really want to use some other language? Click here for a Python example.</summary>

    The transform functions below will add a `spring.application.name=$REPO_NAME` line immediately after the `app.environment` line in all files matching `src/main/resources/*.properties` that don't already contain a `spring.application.name` line.

    - Python version:

      ```sh
      transform() {
        python3 - << EOF
      import re
      import subprocess

      git_paths = subprocess.check_output("git grep --cached -l ''", shell=True)
      for path in git_paths.decode().splitlines():
          if not re.search(r'^src/main/resources/.*\.properties$', path):
              continue
          with open(path) as f:
              contents = f.read()
          if re.search(r'spring\.application\.name', contents):
              continue
          with open(path, 'w') as f:
              f.write(re.sub(r'(app\.environment=\w*)', r'\1\nspring.application.name=${2}', contents))
      EOF
      }
      ```

    - Shell version:
      ```sh
      transform() {
        for path in $(git grep --cached -l ''); do
          if ! printf %s "${path}" | grep -qE '^src/main/resources/.*\.properties$'; then
            continue
          fi
          if grep -qF 'spring.application.name' "${path}"; then
            continue
          fi
          sed -E -i "s/(app\.environment=\w*)/\1\nspring.application.name=${2}/g" "${path}"
        done
      }
      ```

    </details>

1.  Run `./pulldozer /path/to/script.sh`. (To use Bash in your transformation script, prepend `bash` to that command - otherwise Pulldozer assumes POSIX `sh`.) Pulldozer will ask for confirmation and then open PRs, each of which will contain your transformation script in its description.

    <img src=".github/screenshot.png" alt="Screenshot" width="500">

_Duolingo is hiring! Apply at https://www.duolingo.com/careers_
