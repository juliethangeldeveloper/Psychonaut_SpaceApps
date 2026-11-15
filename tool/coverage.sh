#!/bin/sh
# Runs the tests with coverage and prints line coverage for lib/, ignoring generated localization code.
set -e
flutter test --coverage
python3 - <<'PY'
import re
files = {}
cur = None
for line in open('coverage/lcov.info'):
    line = line.strip()
    if line.startswith('SF:'):
        cur = line[3:]
        files[cur] = [0, 0, []]
    elif line.startswith('DA:') and cur:
        n, hits = line[3:].split(',')[:2]
        files[cur][1] += 1
        if int(hits) > 0:
            files[cur][0] += 1
        else:
            files[cur][2].append(int(n))
tot = hit = 0
rows = []
for f, (h, t, miss) in files.items():
    if '/l10n/generated/' in f:
        continue
    tot += t
    hit += h
    if h < t:
        rows.append((t - h, f, h, t, miss))
print(f'Line coverage (generated code excluded): {hit}/{tot} = {100 * hit / tot:.2f}%')
for _, f, h, t, miss in sorted(rows, reverse=True):
    print(f'  {f}: {h}/{t}, missing lines {miss}')
PY
