# Pharmakaksha · GPAT 2027 batch

A one-page brochure for Pharmakaksha's GPAT 2027 batch, live at <https://gpat27.pharmakaksha.com>. It is a single static `index.html` in the ed-tech app design (`templates/edtech-app.html` in the rrb-2026 repo), with no build step. Fonts load from Google Fonts. Everything else is inline.

## What's on the page

| Section | What it shows |
| --- | --- |
| App bar and hero | Logo, Register button, a "Registrations open till …" badge, the headline and a countdown to the next date |
| Quick stats | 125 questions · 180 minutes, +4 / −1 marking (500 max), score valid 3 years, lowest batch fee |
| Dates | Our batch dates, plus the NBEMS dates marked "Awaited from NBEMS", with GPAT 2026 dates for reference. Status chips are worked out in IST |
| Section weightage | Questions, marks, share of the paper and minutes at exam pace for each blueprint section, with a search box. Below it: a percentile, rank and qualifying explainer, the category split of the top 10%, and the tie-breakers |
| Eligibility | Checklist, year-of-study tiles, NBEMS exam fees |
| Pattern | Donut of the blueprint, a 4-step stepper (CBT → result → qualify → use the score), a score calculator (+4 / −1) and "Should you guess?" |
| Inside the batch | Daily tests (20 Qs), weekly tests (40 Qs), 5 full-length mocks, PYQs, notes, one-to-one |
| Syllabus | The 5 blueprint sections as accordions, each listing what our batch covers there |
| Study plan | Progress card and one card per week, then mocks and the exam (built from `PLAN`) |
| Pricing | Day 1 free card, Individual (promo code with Copy) and Group prices, contact buttons |
| Footer and sticky bar | Social links, source and disclaimer; "n days to …" with Share and Register |

After `regClose`, the badge says registrations are closed, the free-trial card hides, and the Register buttons change to "Ask about the next batch", linking to WhatsApp chat.

## Editing

Everything you'll usually change is at the bottom of the `<script>` in `index.html`.

### `CONFIG`

| Key | Meaning |
| --- | --- |
| `fee`, `code`, `codeOff` | Standard fee, promo code, ₹ off with the code |
| `groupMin`, `groupOff` | Group size and ₹ off per person (doesn't combine with the code) |
| `regClose` | When registrations close, as an ISO time with `+05:30` |
| `batchStart` | Text shown above Pricing |
| `exam` | The GPAT 2027 start time once NBEMS announces it, e.g. `"2027-03-06T09:00:00+05:30"`. While it's `""`, the page says "Awaited from NBEMS". Once it's set, the countdown and the exam card use it |
| `mocks` | Number of full-length mocks shown on the plan |
| `planDraft` | `true` shows a "Draft" chip on the study plan. Set it to `false` once the plan is final |
| `cutoffs`, `cutoffYear` | Past-year qualifying marks out of 500 by category (`gen`, `res`, `pwd`). Fill these only from a source you trust. While they're `null`, the calculator shows no cut-off marker |
| `whatsapp`, `chat`, `email`, `register`, `url` | Links. They are also written into the HTML, so they work without JavaScript. If you change one, change both places |
| `shareText` | WhatsApp share message (the page URL is added after it) |
| `cfAnalyticsToken` | Cloudflare Web Analytics token. It loads only on gpat27.pharmakaksha.com. `""` turns it off |

### `MILESTONES`

The dates the countdown runs to, each `{ at, label, short }`. `short` is the label in the sticky bar. The exam is added automatically from `CONFIG.exam`.

### `PLAN`

One entry per row, in order:

- `{ phase: "…" }`: a section label
- `{ week, from, to, topics: [...], pyq: "…" }`: one week, with `to` being the Sunday of the weekly test. Add `free: true` to the first week for the "Day 1 free" chip
- `{ mocks: true, from, note }`: the mock stretch
- `{ exam: true }`: the exam card

The progress bar and the "This week" and "Done" chips work themselves out from these dates.

### Exam facts in the HTML

The exam facts are written into the HTML: the important dates, weightage, eligibility, fees, pattern, stepper, guessing figures and syllabus. Update them when the GPAT 2027 bulletin comes out. At the same time, update the `<head>` preview tags (title, description, `og:*`) and bump the `?v=` on `og:image`.

## Share images

- `og-image.jpg` (1200×630) is the link preview. Its source is `marketing/src/og-image.html`.
- `marketing/whatsapp-status-1080x1920.jpg` is a WhatsApp status. Its source is `marketing/src/whatsapp-status.html`.

Both repeat numbers from `CONFIG`: the lowest fee, the promo code, the group price, the batch start and the registration close. If you change those, edit the HTML sources, then re-render from the repository root (needs Google Chrome on macOS):

```sh
sh marketing/src/render.sh
```

## Deploy

GitHub Pages, via `.github/workflows/deploy.yml`. Every push to `main` publishes only `index.html`, `logo.jpg`, `CNAME`, `.nojekyll` and `og-image.jpg`. The custom domain is in `CNAME`, and DNS has a CNAME record `gpat27 → ajreddys.github.io`.

## Files

| File | Purpose |
| --- | --- |
| `index.html` | The page |
| `logo.jpg` | Logo and favicon |
| `og-image.jpg` | Link preview image |
| `CNAME`, `.nojekyll` | Pages domain and no Jekyll processing |
| `.github/workflows/deploy.yml` | Pages deploy |
| `marketing/src/` | HTML sources and `render.sh` for the share images |
| `marketing/whatsapp-status-1080x1920.jpg` | WhatsApp status image (not deployed) |

## Source

NBEMS has not yet released the GPAT 2027 bulletin. Until it does, the exam facts come only from NBEMS's *Information Bulletin – GPAT 2026*, shown on the page as reference. Anything that bulletin doesn't cover is marked "Awaited from NBEMS". The study plan and the "covered in our batch" lists are Pharmakaksha's own and are not an NBEMS syllabus. Pharmakaksha is not affiliated with NBEMS or the Pharmacy Council of India.
