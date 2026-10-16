# Hermes Settings

## 1. Installation

```sh
curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash
```

Wait for 5 minutes ...

## 2. Set up (basic)

Select "Full setup" in the following phase.

```
How would you like to set up Hermes?
  ↑↓ navigate  ENTER/SPACE select  ESC cancel

   (●) Quick Setup (Nous Portal) — free OAuth login, no API keys, model + tools (recommended)
 → (○) Full setup — configure every provider, tool & option yourself (bring your own keys)
   (○) Blank Slate — everything off except the bare minimum; opt in to each capability
```

Select "Custom endpoint" when using self-hosted model in the following phase.

```
Select provider:
  ↑↓ navigate  ENTER/SPACE select  ESC cancel
...
 → (○) Custom endpoint (enter URL manually)
...
```

* Enter "API base URL" (e.g. "https://xxx.com/v1")
* Enter "API key" (optional)
* Select API compatibility mode -> Auto-detect
* Select model
* Context length in tokens -> (blank)
* Display name -> (default)
* Select reasoning effort -> high or xhigh (different among models)
* Select terminal backend -> Keep current (local)
* Select platform to configure -> Slack

## 3. Slack settings

The following message should be shown:

```
✓ Slack app manifest written to: $HOME/.hermes/slack-manifest.json
    Paste it into https://api.slack.com/apps → your app → Features → App Manifest → Edit, then Save.
    Slack will prompt to reinstall if scopes or slash commands changed.
    Re-run `hermes slack manifest --write` anytime to refresh after Hermes adds new commands.
```

### 3.1. Prepare Slack Bot Token

Go to "https://api.slack.com/apps"
* Click "Create New App"
* Click "From a manifest"
* Input contents of $HOME/.hermes/slack-manifest.json
    * However, remove "assistant_view", "oauth_config>scopes>bot>assistant:write", "slash_commands"
* Scroll down and select a workspace
* Click "Next" -> "Create"

Choose "Settings > Install App" in the left pain
* Click "Install to workspace"
* Click "Allow"
* Bot User OAuth Token xoxb-... is shown. Copy it.

Back to the terminal
* Slack Bot Token (xoxb-...) -> Paste the token.

### 3.2. Prepare Slack App Token

Back to the browser.

Choose "Settings > Basic Information" in the left pain
* Scroll down to App-Level-Tokens section, and click "Generate Token and Scopes"
* Input token name (e.g. default)
* Select scope -> connections:write
* Token xapp-... is shown. Copy it.

Back to the terminal
* Slack App Token (xapp-...) -> Paste the token.

### 3.3. Configure Slack App

Back to the browser.

Choose "Settings > Basic Information" in the left pain
* Scroll down to Display Information
  * Set App name (which is the name displayed when browsing apps)
  * Set short description
  * Set icon
  * Set background color
  * Click Save Changes (Don't forget!)
Choose "Features > App Home" in the left pain
* Your App’s Presence in Slack > App Display Name > Edit
  * Set Display name (which is the name displayed in chat window)
  * Set default username (e.g. as the same as app name)
  * Click Save

### 3.4. Input IDs in Slack App

In the terminal
* Allowed user IDs
    * Show profile by clicking icon
    * Click ︙
    * Copy member ID (usually begins from U)
* Home channel ID
    * Browse apps
    * Find name which is set in "Set App name"
    * Click and open the chat window
    * Click ︙ (More actions)
    * App details > Open app details
    * Copy Channel ID

## 4. Remaining steps

* Tools for CLI -> Enter
* Choose browser -> Chromium (free)
* Choose a provider -> Skip
* Skip basically

Confirmation
* Run hermes and enter hello to confirm.
* Chat to hermes in slack app.
