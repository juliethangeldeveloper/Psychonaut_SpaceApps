# Psychonaut

*"Outer space is the mission. Inner space is the journey."*

- **Event:** 2026 NASA Space Apps Challenge
- **Challenge:** Create Health Monitoring Software for Astronauts on Space Missions
- **Team:** Psychonaut

> **Disclaimer:** Psychonaut does not diagnose and does not replace a clinician or flight surgeon. It is a hackathon prototype that runs on sample data.

## App demos

Watch the sample recordings: 

[Chrome App sample/Desktop]


https://github.com/user-attachments/assets/3481fdb8-37d0-44ee-9076-dd299fcc1867

[Mobile App sample iOS - Questionary]



https://github.com/user-attachments/assets/b8e7c90a-7ca0-4eec-bc46-b9c76365b2cc



[Mobile App sample Android]


https://github.com/user-attachments/assets/770c05de-a005-4d62-8a97-a3f8590413e7



[Mobile App sample Android - Spanish]


https://github.com/user-attachments/assets/3c8dc897-30be-47cc-abae-9242c8e8c61d



Psychonaut targets web, iOS and Android mobile devices, macOS, and Linux. Linux has not yet been built or tested; see the platform notes below.

## The problem

On a long mission there is no psychologist on board, and contact with Earth is delayed. Small changes in mood, sleep, focus or crew connection can build for weeks before anyone notices them.

## What Psychonaut does

Psychonaut is a daily psychological health companion. It compares each person only with their own baseline, explains every reading and suggests one small action.

- **Before launch:** a personality profile from the 20-item Mini-IPIP questionnaire in the app, or from the 120-item IPIP-NEO-120 imported as a JSON file, which adds four facet scores. Three more questions set locus of control (after Rotter), preferred tone and preferred actions. The profile changes how soon a change is flagged, how advice is framed and which actions come first.
- **Every day:** a six-slider check-in in the Captain's log (mood, stress, workload, engagement, focus and crew connection) with an optional private "Something happened at home" note, plus wearable data on sleep, heart rate variability, resting heart rate and activity. A streak counts entries, never scores. Every 4 days, a 3-minute reaction test records reaction time, lapses and false starts. In this prototype the wearable data comes from sample files and only sleep is scored.
- **The reading:** each indicator is compared with the personal baseline and given one of four risk levels: on course, drifting, off course or alert. Together they give one "degrees off course" number. A mismatch is flagged when someone reports feeling fine while their sleep or reaction time has been off baseline for a week. At alert level the app always shows one fixed message: "Tell your crew medical officer and prepare a summary for Earth".
- **The response:** one suggested action from a fixed list, three answers for each indicator (how it's measured, why it matters and what to do) and the NASA risk it relates to. Trends shows 14 nights of sleep and the reaction test history, and Ship morale shows the crew's wellbeing as one anonymous number with a shared weekly goal.
- **The daily reading:** written by rules on the device by default. A crew can instead choose an on-board AI model that keeps everything on the vehicle, or a cloud model for use on Earth.

It runs on a phone, a tablet or a crew console, in English, Spanish, French, Japanese, Arabic and Russian.

## Impact

- **In space:** early warning for crews with no psychologist on board and delayed contact with Earth.
- **On Earth:** the same approach can help people far from care, such as remote communities and older adults living alone.

## What makes it different

- **The personality profile changes the app.** It shifts how soon a change is flagged and how advice is worded. A person with an internal locus of control gets the data and options. A person with an external one gets one clear step.
- **The mismatch flag.** It is raised when someone reports feeling fine while their sleep or reaction time has been off baseline for 7 or more days.
- **The ship metaphor.** It rewards honest check-ins, not good scores, and there is no leaderboard.
- **Fully offline.** It runs on a phone or crew console with no network.

## Built with

Flutter 3.50 and Dart, one codebase for iOS, Android, macOS, Linux and web, with a Material 3 dark theme.

- **Packages:** flutter_riverpod (state), go_router (navigation), fl_chart (charts), shared_preferences (on-device storage), file_picker (profile import), http (optional model calls), intl and flutter_localizations (six languages), material_ui, cupertino_ui and cupertino_icons.
- **Development only:** flutter_test, flutter_lints, clock and cross_file.
- **Fonts, bundled for offline use:** Inter, Space Grotesk, Noto Sans Arabic and Noto Sans JP.

Versions are in `pubspec.yaml`. Links are in the resources table below.

## How to run and test

The app works with no API key and no network.

```
flutter pub get
flutter run -d macos
flutter run -d chrome
flutter run -d <ios simulator id>
flutter run -d <android emulator id>
flutter run -d linux

flutter analyze
flutter test
./tool/coverage.sh
```

`flutter devices` lists device ids. All 220 tests pass, and line coverage of `lib/` is 99.75%, leaving out generated localization code, the wearable stub and four private constructors. The current code builds for macOS, web, iOS and Android. It has been run on macOS and Chrome, and on the iOS simulator and Android emulator before the reaction test was added. It has not been built on Linux, which needs a Linux machine.

**Optional AI models.** Both are off by default. Pass the values at build time, then choose the source in Profile, AI source.

```
# Cloud model: HTTPS endpoint in the OpenAI-compatible chat completions format
flutter run -d macos \
  --dart-define=LLM_API_KEY=<your key> \
  --dart-define=LLM_ENDPOINT=https://api.anthropic.com/v1/chat/completions \
  --dart-define=LLM_MODEL=<model name>

# On-board model: a local address only, no key
flutter run -d macos \
  --dart-define=ONBOARD_ENDPOINT=http://localhost:11434/v1/chat/completions \
  --dart-define=ONBOARD_MODEL=<model name>
```

- Never write a key into a file in this repository. A key passed this way is embedded in the built app, so do not publish that build.
- If a model is not set up, fails or is too slow, the reading falls back to the rule-based source and says so.
- Both model options have been tested against a fake server only, not a real model.
- The cloud example uses Claude. Anthropic's OpenAI SDK compatibility documentation (https://platform.claude.com/docs/en/api/openai-sdk) gives `https://api.anthropic.com/v1/` as the base URL, so the full chat completions endpoint is the one above. Anthropic describes this compatibility layer as intended for testing and comparing models, not as a long-term production solution. Use a key scoped to a workspace, because the app does not send the header that other key types need.
- Any other provider that accepts the OpenAI-compatible chat completions format with a strict JSON schema should also work. Check its documentation for the endpoint and the model name.

## Project structure

```
lib/
  app/        shell, router, providers, responsive layout
  theme/      design tokens and shared widgets
  models/     personality profile, check-in, reaction result, status, insight
  data/       sample data source, wearable stub, local storage
  services/   risk engine, risk_constants.dart, insight services
  features/   onboarding, home, checkin, reaction, trends, crew, profile
  l10n/       translations
assets/       sample profiles, sample health data, fonts
test/         unit and widget tests
tool/         coverage.sh
```

## How the risk engine works

All thresholds live in `lib/services/risk_constants.dart`. The baseline is the mean and standard deviation (SD) of each indicator over the person's first 30 days. Until then the engine uses the profile baseline and a default SD.

| Level | Rule |
| --- | --- |
| On course | Within 1 SD of baseline |
| Drifting | More than 1 SD on the unfavourable side for 3 or more days in a row |
| Off course | More than 2 SD for 3 days, or more than 1 SD for 7 days |
| Alert | Sleep under 5 hours for 3 nights, or three or more indicators off course together |

Rules applied on top:

- **Sleep:** 7 to 8 hours is healthy and 6 hours or less is short sleep. Under 6 hours for 7 nights is off course.
- **Reaction test:** a response slower than 500 ms is a lapse. Two or more lapses above the personal baseline puts Focus at drifting or worse.
- **Mission phase:** after mission day 150 the 1 SD limit tightens to 0.8 SD.
- **Personality:** a trait score of 70 or more, or 30 or less, flags the linked indicator one day sooner.
- **Life event:** for 14 days, mood is flagged one day sooner and "Message home" is offered first.
- **Mismatch:** self-rated mood at or above baseline while sleep is below baseline, or reaction time is more than 0.5 SD slower, for 7 or more days.
- **Degrees off course:** 0 to 90, from 0.6 times the average and 0.4 times the worst indicator.

**From published research and guidance,** as cited in our brief and not validated by us: the 7 to 8 hour sleep range and the 6 hour short-sleep line, the 500 ms lapse, a rested response of about 250 ms, the 3-minute test length, the closer watch after about 5 months, and the Mini-IPIP items and scoring.

**Our own design assumptions:** everything else, including the 30-day baseline, the SD limits and day counts, the 0.8 SD late-mission limit, the 7-night and 3-night sleep rules, the 2 to 5 second stimulus interval, the default SD values, the 70 and 30 trait cut-offs, the mismatch and life-event windows, and the degrees weights.

## Factors we considered

- **Privacy:** by default everything stays on the device, and the data is never used to rank the crew. The Crew screen shows one anonymous group number. The cloud model is optional. If chosen, it sends scores and the personality profile, never the name, role or private notes.
- **Safety:** at alert level the app always shows the fixed message "Tell your crew medical officer and prepare a summary for Earth". It never diagnoses, names a disorder or gives medication advice. Generated text that breaks these rules is rejected, and every reading shows its source.
- **Limits:** the thresholds are assumptions and have not been validated. The app runs on fictional sample data only. Wearable integration is a stub, and only sleep is scored from it. Locus of control comes from one self-rated question, not a validated scale. The reaction test is not a validated instrument. The Spanish, French, Japanese, Arabic and Russian text was machine-drafted and has not been reviewed by native speakers.

## Future integrations

None of this is built yet. It is the path from prototype to full product.

- **Wearables:** replace the stub with real data from Apple Health and Health Connect, score heart rate variability, resting heart rate and activity, and build the baseline from the first 30 days of real data.
- **On-board AI:** run the reading on a local model inside the device or on the vehicle network, so nothing leaves the vehicle. The setting and safety checks exist. It still needs testing with a real model and support for phones and tablets.
- **Longer personality test:** move to the 120-item IPIP-NEO-120 for 30 facets. A crew member who has already taken it can load their scores through the profile import, as a JSON file in the app's format.
- **One connected product:** wearable, app, on-board model and crew console working together, with a summary for the crew medical officer and for Earth sent with the crew member's consent.
- **Validation:** test the thresholds with analog mission data, use validated translations and run a formal accessibility audit.

## Use of Super Intelligence (SI) tools

The idea is the team's own. We chose the challenge and set the direction: a psychology-first tool focused on prevention, wearable data, and a personality profile for each crew member, including locus of control and boredom proneness. We also came up with the name and the played around with slogan. 

| Where | Tool | How it was used |
| --- | --- | --- |
| Research and written text | Claude (Anthropic) | Research to find the evidence base for the team's idea, and help drafting written text |
| App code and unit tests | GitHub Copilot, an AI coding assistant, running the Claude Fable 5.2 model | Generated the Dart code in `lib/`, the tests in `test/`, `tool/coverage.sh` and the five translations, following the team's specification, and drafted this README from the team's brief. Reviewed by the team. |
| Screen designs, logo and cover image | Claude (Anthropic) | Generated with Claude. Exported images carry a visible "SI-generated" watermark. |
| Sample profiles and sample health data | GitHub Copilot | SI-generated and fictional. They do not describe real people. |

No SI-generated content uses, contains or modifies NASA branding or design elements. An SI acknowledgement is at the top of `pubspec.yaml` and in the `siNotice` field of every file in `assets/profiles` and `assets/sample`.

## NASA data and resources

| Name | URL |
| --- | --- |
| NASA Human Research Program: 5 Hazards of Human Spaceflight | https://www.nasa.gov/hrp/hazards/ |
| NASA Human Research Program: Human Health Risks | https://www.nasa.gov/hrp/risks/ |
| NASA Human Research Program: Ongoing Research | https://www.nasa.gov/hrp/ongoing-hrp-research/ |
| NASA Behavioral Health Risk Record, Rev D.1 | https://www.nasa.gov/wp-content/uploads/2025/09/hsrb-behavioral-health-risk-record-rev-d-1-web.pdf |
| NASA: Risk of Behavioral Conditions and Psychiatric Disorders | https://www.nasa.gov/reference/risk-of-behavioral-conditions-and-psychiatric-disorders/ |
| NASA: Risk of Inadequate Teamwork | https://www.nasa.gov/reference/risk-of-inadequate-teamwork/ |
| NASA: Risk from Inadequate Sleep and Irregular Schedules | https://www.nasa.gov/reference/risk-from-inadequate-sleep-and-irregular-schedules/ |
| NASA Technical Reports: APEX Suite results | https://ntrs.nasa.gov/citations/20260002661 |
| NASA Technical Reports: Spaceflight Standard Measures | https://ntrs.nasa.gov/api/citations/20200001281/downloads/20200001281.pdf |
| NASA Technical Reports: Sleep in long-duration spaceflight | https://ntrs.nasa.gov/citations/20000029468 |
| NASA Spinoff: Reaction Self-Test | https://spinoff.nasa.gov/Spinoff2013/hm_1.html |

## Space agency partner and other resources

| Name | URL |
| --- | --- |
| Canadian Space Agency: Why do we conduct science experiments in space | https://www.asc-csa.gc.ca/eng/iss/science/why-do-we-conduct-science-experiments-in-space.asp |
| Canadian Space Agency: Monitoring radiation for astronaut health | https://www.asc-csa.gc.ca/eng/news/articles/2026/2026-02-26-monitoring-radiation-astronaut-health.asp |
| International Personality Item Pool (Mini-IPIP items, public domain) | https://ipip.ori.org |
| The Mini-IPIP scales, Donnellan et al. 2006 | https://pubmed.ncbi.nlm.nih.gov/16768595/ |
| IPIP-NEO-120 structure study, Kajonius and Johnson 2019 | https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7871748/ |
| Locus of control: Rotter 1966, Generalized expectancies for internal versus external control of reinforcement | https://pubmed.ncbi.nlm.nih.gov/5340840/ |
| Astronaut sleep and vigilant attention study | https://pmc.ncbi.nlm.nih.gov/articles/PMC8919197 |
| Cognition test battery, University of Pennsylvania | https://www.med.upenn.edu/uep/cognition.html |
| Flutter | https://flutter.dev |
| Inter typeface | https://fonts.google.com/specimen/Inter |
| Space Grotesk typeface | https://fonts.google.com/specimen/Space+Grotesk |
| Noto Sans Arabic typeface | https://github.com/google/fonts/tree/main/ofl/notosansarabic |
| Noto Sans JP typeface | https://github.com/google/fonts/tree/main/ofl/notosansjp |
| material_ui | https://pub.dev/packages/material_ui |
| cupertino_ui | https://pub.dev/packages/cupertino_ui |
| cupertino_icons | https://pub.dev/packages/cupertino_icons |
| flutter_riverpod | https://pub.dev/packages/flutter_riverpod |
| go_router | https://pub.dev/packages/go_router |
| fl_chart | https://pub.dev/packages/fl_chart |
| shared_preferences | https://pub.dev/packages/shared_preferences |
| file_picker | https://pub.dev/packages/file_picker |
| http | https://pub.dev/packages/http |
| intl | https://pub.dev/packages/intl |
| flutter_lints | https://pub.dev/packages/flutter_lints |
| cross_file | https://pub.dev/packages/cross_file |
| clock | https://pub.dev/packages/clock |
| flutter_localizations and flutter_test (part of the Flutter SDK) | https://flutter.dev |
| Anthropic: OpenAI SDK compatibility (cloud model example) | https://platform.claude.com/docs/en/api/openai-sdk |

## Team

| Name | Role |
| --- | --- |
| Julieth Lorne | Mission Systems Engineer |
| Laura Chavez | Human Factors & Behavioral Health Lead |

## Licence

The code in this repository is released under the MIT License. See the `LICENSE` file.

Third-party parts keep their own terms. The bundled fonts in `assets/fonts` are under the SIL Open Font License; their licence files are in the same folder. The Flutter packages are under the licences listed on their pub.dev pages. The Mini-IPIP items come from the International Personality Item Pool, which is in the public domain.

This project is original work created for the 2026 NASA Space Apps Challenge. It is not endorsed by NASA or any space agency, and it uses no NASA logos, flags or mission identifiers.
