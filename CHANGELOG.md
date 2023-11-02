## [Unreleased]

## [0.8.0] - 2023-11-02

### Breaking

- Renamed `as_json` to `to_h` details outlined in https://github.com/chadwilken/tiptap-ruby/issues/10.

## [0.7.0] - 2023-11-02

### Breaking

- Renamed `to_json` to `as_json` to follow Ruby/Rails convention.

## [0.6.1] - 2023-11-01

- Allow customizing the `separator` when calling `to_plain_text`.

## [0.6.0] - 2023-11-01

- Implement `Enumerable` for the `HasContent` module.

## [0.5.0] - 2023-10-30

- Make `Text` a subclass of `Node`.
- Try to unify the interface a bit more for the initialize method.

## [0.4.0] - 2023-10-29

- Extract `Registerable` module from `JsonRenderable` so that Node registration is separated from being JSON renderable.
- Make `Document` a subclass of `Node`.

## [0.3.0] - 2023-10-29

- Tweak dependency version requirements to be greater than or equal to

## [0.2.0] - 2023-10-28

- Add `Blockquote` and `Codeblock` nodes
- Add support for `strike`, `code`, and `textStyle` marks

## [0.1.0] - 2023-10-28

- Initial release
