## v0.10.0
- #82: Add R Markdown flavor
- #79: Spec for custom commands

## v0.9.0
- #74: Add support for AtomDoc references, such as {ClassName} and {Class::method}
- #75: Separate `gfm-blocks` from `gfm-inlines` and add the latter to `inlines-in-blocks`; makes references work inside tables again
- #76: Mark the checkbox in task-list-items as a separate token

### v0.8.1
- #70: Don't disable `language-gfm` if it is already disabled (thanks @KaiBueker)

## v0.8.0
- Remove the automatically created empty list-item after pressing <kbd>enter</kbd> if left empty (+option to disable this)
- Add fenced-code-block support for `jsx`, `sass` and `scss` (thanks to @afc163 and @afontaine)
