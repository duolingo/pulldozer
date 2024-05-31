# Pulldozer

Pulldozer is a simple CLI tool for batch editing multiple GitHub repos.

You give Pulldozer a transformation script and it spits out pull requests. [Duolingo](https://www.duolingo.com/) has used Pulldozer to create well over 9000 PRs to date!

## Usage

Clone this repo onto any Unix machine that has [`curl`](https://brewinstall.org/install-curl-on-mac-with-brew/). Set your `GITHUB_TOKEN` environment variable to an [access token](https://github.com/settings/tokens) with `repo` scope and [SSO enabled](https://docs.github.com/en/github/authenticating-to-github/authorizing-a-personal-access-token-for-use-with-saml-single-sign-on). To perform a batch edit (a.k.a. _codemod_):

1.  Create a script file that defines a `COMMIT_MESSAGE` string, `transform` function, and `REPOS` list.

    <details><summary>Click here to see a Shell example</summary>

    ```sh
    COMMIT_MESSAGE='Fix "langauge" typos'

    transform() {
      # Write your transformation logic inside this function. GitHub org name
      # and repo name are passed into this `transform` function as vars $1 and
      # $2, respectively.
      echo "Hello world from $1/$2" > README.md

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

    By default, Pulldozer will interpret your script as POSIX shell. If you want to use Bash instead, just run `bash ./pulldozer` instead of `./pulldozer` during step 2 below.

    </details>
    <details><summary>Click here to see a JavaScript example</summary>

    ```js
    const COMMIT_MESSAGE = 'Fix "langauge" typos';

    // Write your transformation logic inside this function. GitHub org name and
    // repo name are passed in as parameters.
    const transform = async (org, repo) => {
      const { writeFile } = require("fs").promises;
      await writeFile("README.md", `Hello world from ${org}/${repo}`);

      // Pulldozer provides a `replace_all` helper function (no need to import)
      // for replacing text across all repo files. This helper is easier than
      // traversing the repo yourself, and it also respects .gitignore.
      await replace_all("langauge", "language");

      // Advanced `replace_all` example: regex, capture grouping, multiline
      // matching, editing only a subset of repo files (optional third param)
      await replace_all(
        /(\nprotobuf==)\S+/,
        "$13.19.4",
        /requirements\.(in|txt)$/,
      );
    };

    const REPOS = [
      "artnc/dotfiles",
      "duolingo/halflife-regression",
      "duolingo/rtl-viewpager",
    ];

    // Optional: Markdown to include in pull request descriptions
    const DESCRIPTION =
      "[Correct spelling](https://en.wiktionary.org/wiki/language)";
    ```

    </details>
    <details><summary>Click here to see a Python example</summary>

    ```py
    COMMIT_MESSAGE = 'Fix "langauge" typos'

    # Write your transformation logic inside this function. GitHub org name and
    # repo name are passed in as parameters.
    def transform(org, repo):
        with open("README.md", "w") as f:
            f.write(f"Hello world from {org}/{repo}")

        # Pulldozer provides a `replace_all` helper function (no need to import)
        # for replacing text across all repo files. This helper is easier than
        # using `os.walk` and `re.sub`, and it also respects .gitignore.
        replace_all("langauge", "language")

        # Advanced `replace_all` example: regex, capture grouping, multiline
        # matching, editing only a subset of repo files (optional third param)
        replace_all(r"(\nprotobuf==)\S+", r"\13.19.4", r"requirements\.(in|txt)$")

    REPOS = [
        "artnc/dotfiles",
        "duolingo/halflife-regression",
        "duolingo/rtl-viewpager",
    ]

    # Optional: Markdown to include in pull request descriptions
    DESCRIPTION = "[Correct spelling](https://en.wiktionary.org/wiki/language)"
    ```

    </details>

1.  Run `./pulldozer /path/to/your/script`. Pulldozer will generate a preview diff and ask for confirmation before creating PRs.

## Demo video

![Recording](demo.gif)

_Duolingo is hiring! Apply at https://www.duolingo.com/careers_
