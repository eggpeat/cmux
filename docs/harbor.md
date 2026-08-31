# Harbor

Harbor is cmux's terminal-session index. It discovers local and SSH-hosted
cmux-tui, tmux, zellij, GNU screen, zmx, and Herdr sessions, then exposes one
row for each attachable terminal.

The Herdr rows follow Herdr's public agent lifecycle vocabulary and terminal
session-control API. See the [Herdr repository](https://github.com/herdrdev/herdr)
and [CLI reference](https://github.com/herdrdev/herdr/blob/master/docs/next/website/src/content/docs/cli-reference.mdx).
Harbor does not copy Herdr source code. Herdr is licensed under Apache-2.0;
Harbor code remains under cmux's project license.

Harbor currently uses Herdr's terminal attach command inside a cmux manual-IO
terminal. Direct frame-level `terminal session control` integration is a later
step, because it needs a separate JSON frame pump and resize lifecycle.
