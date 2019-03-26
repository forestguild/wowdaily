# Warcraft daily data parser for Jekyll

[![Gem Version](https://badge.fury.io/rb/jekyll-wowdaily.svg)](https://badge.fury.io/rb/jekyll-wowdaily)

[Live Example](https://forestguild.club/) (Russian) - plugin built specially for this website

Data parsed from [Wowhead](https://wowhead.com) block "Today in WoW"

## Configuration

Add following block to your jekyll config (`_config.yml`)

```yml
wowdaily:
  region: eu # Region code
  lang: ru # Wowhead language code
```

## Usage

```bash
# If you set all configs in site config file:
jekyll wowdaily # check _data/wowdaily_lang_region.json

# If you want to set custom config
jekyll wowdaily --help
```

