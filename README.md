# Pulldozer

Pulldozer is a simple CLI tool for batch editing multiple GitHub repos.

You give Pulldozer a transformation script and it spits out pull requests. There are no other side effects - your existing local repos will remain untouched.

## Usage

Clone this repo onto any Unix machine that has [`curl`](https://brewinstall.org/install-curl-on-mac-with-brew/). Set your `GITHUB_TOKEN` environment variable to an [access token](https://github.com/settings/tokens) with `repo` scope.

To perform a batch edit:

1.  Specify your desired `COMMIT_MESSAGE` string, `REPOS` list, and `transform` function in a shell script:

    ```sh
    COMMIT_MESSAGE='Fix "langauge" typos'

    REPOS='
    artnc/dotfiles
    duolingo/halflife-regression
    duolingo/rtl-viewpager
    '

    transform() { # $1=org name, $2=repo name
      # Replace all occurrences of "langauge" with "language"
      git grep --cached -z -l '' | xargs -0 sed -i 's/langauge/language/g'
    }
    ```

    <details><summary>Shell skills rusty? Click here for a cheat sheet.</summary>

    - List all Git-tracked files containing `$needle` with `git grep --cached -l $needle`
      - To simply list all files, specify `-l ''`
      - `-z` will use `\0` instead of newline as the delimiter
        - Required if you'll be piping paths containing whitespace into `xargs`
      - Symlinks and submodules are excluded
    - Pipe a file list into `xargs $command` to run `$command $file` on each file in the list
      - Use `xargs -0` if the input is `\0`-delimited rather than newline-delimited
    - Replace strings in a file with `sed -i -e 's/myRegex/mySubstitution/g' $file`
      - You can use any character in place of `/` as the delimiter if conflicts arise
      - You can specify `-E` and then reference parenthesized capture groups with `\1` etc.
      - You can declare multiple substitutions by placing `-e` before each one
      - To [replace newlines](https://stackoverflow.com/a/1252191), add `-e ':a' -e 'N' -e '$!ba'` before your own `-e 's/\n/foobar/g'`
    - If you'd rather not write shell code, you can always drop into another language:
      ```sh
      transform() {
        org="${1}"
        repo="${2}"
        python3 ~/apply-super-complex-transformation-to-repo.py "${org}" "${repo}"
      }
      ```

    </details>

1.  Run `./pulldozer /path/to/script.sh`. (To use Bash in your transformation script, prepend `bash` to that command - otherwise Pulldozer assumes POSIX `sh`.) Pulldozer will ask for confirmation and then open PRs:

    <img src=".github/screenshot.png" alt="Screenshot" width="500">

_Duolingo is hiring! Apply at https://www.duolingo.com/careers_
