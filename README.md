# THIS PROJECT IS VAPORWARE

Gjallarbru is a tool for authoring HTML/CSS templates with quick development
feedback and placeholders for programmatic data.

This project doesn't exist yet. Here are the initial goals.

## Design goals

1. Get out of the way of HTML/CSS developers

    Support 100% of modern HTML and CSS, with minimal modification for
    supporting template variables. Provide additional tools for correctly
    preparing the templates for integration into web apps.

2. Integrate templates seamlessly into web apps

    Once the HTML/CSS developer is finished, the templates must not require
    additional modification to be usable by web apps. Gjallabru will provide
    tools to assist modifying web apps (in as many languages as possible) to use
    new/updated templates.

## Implementation considerations

1. Regardless of surface language, use a simple, standards-compliant "core"
   language.

    Supporting sophisticated UIs may spur the development of syntactic sugar
    for "widgets" or other abstractions. No matter what this surface language
    develops into, it must always desugar to modern HTML and CSS.
