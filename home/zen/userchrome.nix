# ft=css
{ rice, ... }: /* css */ with rice.col; ''
/* Catppuccin Mocha Blue userChrome.css*/

@media (prefers-color-scheme: dark) {
    :root {
        --zen-colors-primary: ${t2.h} !important;
        --zen-primary-color: ${blue.h} !important;
        --zen-colors-secondary: ${t2.h} !important;
        --zen-colors-tertiary: ${t1.h} !important;
        --zen-colors-border: ${blue.h} !important;
        --toolbarbutton-icon-fill: ${blue.h} !important;
        --lwt-text-color: ${fg.h} !important;
        --toolbar-field-color: ${fg.h} !important;
        --tab-selected-textcolor: rgb(171, 197, 247) !important;
        --toolbar-field-focus-color: ${fg.h} !important;
        --toolbar-color: ${fg.h} !important;
        --newtab-text-primary-color: ${fg.h} !important;
        --arrowpanel-color: ${fg.h} !important;
        --arrowpanel-background: ${t1.h} !important;
        --sidebar-text-color: ${fg.h} !important;
        --lwt-sidebar-text-color: ${fg.h} !important;
        --lwt-sidebar-background-color: ${bg.h} !important;
        --toolbar-bgcolor: ${t2.h} !important;
        --newtab-background-color: ${t1.h} !important;
        --zen-themed-toolbar-bg: ${t1.h} !important;
        --zen-main-browser-background: ${t1.h} !important;
        --toolbox-bgcolor-inactive: ${t1.h} !important;
    }

    /* fg col */
    .tab-text,
    .urlbar-input,
    .urlbarView-title {
        color: ${fg.h} !important;
    }

    /***************/
    /* tab sidebar */
    /***************/
    #TabsToolbar {
        background-color: ${t1.h}00 !important;
    }

    hbox#titlebar {
        background-color: ${t1.h}00 !important;
    }

    .tab-background[selected] {
        background-color: ${fg.h}28 !important;
        filter: blur(3px);
    }

    .tabbrowser-tab:hover .tab-background {
        background-color: ${fg.h}18;
        filter: blur(3px);
    }

    /* v cute colorful icons v */
    .tab-icon-image[src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAFNElEQVRYR8WXW2wUVRjHf2d2dku7W7bQaqEIAhKQYm1JfJBLUR9MDEqAPqCJl0AClqhBjA/4oEFMRGM0kpAI6oPGBC8xSi0Go4mhQJFIFIoWQYhCa7S0QO/b2+7MZ87M7uzs9pqI4deczOnZ7zvff875zmUUE0REKoA1wL3APd4PmRwG6oAapVSD1zoGyquNgoisB7YC5V7jxDgN7FJKfei1jMCoAkRkNqCdR3vbiaJHZb1S6pLX4mNEASKih1oHj3qN/42upIgaryXJMAHJIf/Aa/DzQz0cq4dfGqCtFUQ3Gm43xdOQ8nJYVolacnfKI5sN2VOSISD55vu9hhSNJ+HtndDaCnHT9RLlFhUAAs5TjACin9OmY2x9ClW2yOvCx1r/SHgCknOuMzdz2D9/HWq+gN6Q+/9QKB1cuystyC2CQgJBxAg6pmrVAxgbH3f90ujpqEjlhF+AXj6ZCffxC3D0a+jOhaFAsowhIDUKKQFzZmG8+hKE85IdehxWSunl7AoYcd6/2wI/74e+IFyNQL8JAyb05oBtgKVdTTB0YNOpi6GFGI6AMYKncPIhJUAPfXqdt9VC3WPQnA+TbGjNh5YwGALmXKjaBEsqIRxx7WMxOP4j9r7P4Gon3DZ3vOCa00qpCpXc4U55zZoj8+HyZYgFIRZyBfQG4c4qWLctHTibWAz56iBq9YPjBU+xWAt4GdjuNXUcgN/XQZ8BA7oE4FoI8qvgkb2e2XVihxaQmXwXn4SufZAAepT7jE2BlY0Qul77ksdhLcDZTjzOlsJgkxs4VQqfhoVveCZ+fmr2qpmIzvB017peElVMK/AWnsMwAdKQ62Sycpaa2xHzvoHJlZ6Nn8WvedVMst5Ls7kSqivHFTDJ2dmU3uFsG1EKVaqH/1bPxs+oAvzoEEqxebmML8A+FUKpoCPA+6n0DCo0y61nMSEBSaqXu6PgZ7iAk6YT3CaABVgI5rxvCeav8Gz8aAGCnZwrjXL+0qTrExPQOA8ZaqJX7zkqQLttkVu8haKZb3k2fvYe1e7+LtyAtb9Ci971JyAgYxkmLm3AuvYRAxgMCgwCV40CysovYAYKUmZj0jMAK98RerWzgyvi/UfhrsyZdJZhxkYU76yh7UIVHQI2ijaBZjtI4dQ1rF7wacpsTHYdj/HuUYVlWISsEEoMRAmN25InahpnIxq2FZ9qmE3zQBM5KNoFLskk2iWXhTc9wcNzXyFi5nu22ew58zfbj/RiWjnYyiY8FCUnHmbNHQF2rnRPSR+LnbHJPoy6u+s49Nt9dIqiSwwuSph2O48OCTMUKmfj7GruL1pG1AynXKht+YPd585T39JPqH8mZiKXYCLPERCwghzalM+MqD85k4eRro10HNddfI5D/+yhS4I0SZRuCdMjYVqtYgYJESeHuB0hEphMZ9xC4lEYnA4SQPXPJJAIE0qECQ5OpbqskB0rhuVP+jjWZCejZt/5ar5sraVFCrHEpMOeQo8UkUBhSQ42QRK2nihBrDD2wHRQNgyWYPaXYBkJKiK3cGxtqddnkswLiWa0K9nu88/yyeXv6bPz6HNGoYiEmFiYjgBb9IYVcARIIoxYEUcAiTCrSubw3tIyoiF9b/QY+UqmGe1SeqLzJM+ffZM/+7vplyiCgeiLKArb1rcgvWRyECsXiU8lIjN48fYlPLNgvteHj5EvpSlGyocUB6+c4MCVBuo7zvHXwDXHXcRwpmByoICl0QpWFS/ioZvLiAZzPD8fY1/LU9zQDxOfiBv3aebnhn2cZvN/fZ7/C+T0M/VuWOGOAAAAAElFTkSuQmCC"] {
        filter: blur(3px) saturate(900%); /* google search icon */
    }
    .tab-icon-image {
        scale: 0.8;
        filter: saturate(250%);
        margin-left: 0 !important;
        margin-right: 5px !important;
    }
    /* ^ cute colorful icons ^ */

    .zen-workspace-tabs-section {
        margin-top: 3px !important;
    }

    .tab-close-button,
    #zen-sidebar-top-buttons,
    .zen-current-workspace-indicator,
    .pinned-tabs-container-separator,
    #tabs-newtab-button { display: none !important; }

    /**********/
    /* urlbar */
    /**********/

    /* v disable clicking off of urlbar v */
    .urlbar::before { scale: 100; }
    
    #urlbar[open][zen-floating-urlbar="true"]::before {
        content: "";
        position: fixed;
        inset: 0;
        z-index: -1;
        pointer-events: auto;
    }
    /* ^ disable clicking off of urlbar ^ */

    /* v move urlbar to bottom v */

    toolbarbutton#zen-create-new-button,
    toolbarbutton#downloads-button {display: none !important;}
    #zen-sidebar-foot-buttons {
        anchor-name: --sidebar-foot;
    }
    
    zen-workspace {
        margin-top: -37px !important;
    }

    .urlbar:not([zen-floating-urlbar="true"]){
        position-anchor: --sidebar-foot !important;;
        position-area: center;
        position: absolute;
        margin-bottom: 30px !important;
    }

    .urlbar-container {
        z-index: 0 !important;
    }
    /* ^ move urlbar to bottom ^ */

    .urlbar-container { background-color: #00000000 !important; }
    .urlbar-background {
        background-color: ${fg.h}30 !important;
        filter: blur(7px);
    }

    .urlbar[zen-floating-urlbar="true"] .urlbar-background {
        background-color: ${bg.h}f0 !important;
        filter: blur(10px);
        scale: 1.04;
    }

    .urlbarView-row strong {
        color: inherit !important;
       font-weight: normal;
    }

    .urlbarView-row:hover,
    .urlbarView-row[selected] {
        background-color: #00000000 !important;    
    }

    .urlbarView-row[selected] .urlbarView-title {
        color: ${blue.h} !important;
    }
    .urlbarView-row:hover .urlbarView-title {
        color: ${purple.h} !important;
    }

    .urlbarView-url {
        color: ${blue.h} !important;
    }
    
    .urlbarView-favicon {
        display: none !important;
    }

    .urlbarView-title-separator::before {
        color: #ff000000 !important;
    }

    #zen-copy-url-button,
    .urlbarView-action,
    .urlbarView-button-menu,
    .urlbar #identity-icon-box,
    .urlbarView-type-icon,
    .urlbarView-switchToTab::after {display: none !important;}
    .urlbarView-switchToTab { margin-right: 0 !important; }

    /*********/
    /* other */
    /*********/
    #permissions-granted-icon {
        color: ${t1.h} !important;
    }

    .sidebar-placesTree {
        background-color: ${t1.h} !important;
    }

    #zen-workspaces-button {
        background-color: ${t1.h} !important;
    }

    .content-shortcuts {
        background-color: ${t1.h} !important;
        border-color: ${blue.h} !important;
    }

    #zenEditBookmarkPanelFaviconContainer {
        background: ${bg.h} !important;
    }

    #zen-media-controls-toolbar {
        & #zen-media-progress-bar {
          &::-moz-range-track {
            background: ${t2.h} !important;
          }
        }
    }

    toolbar .toolbarbutton-1 {
        &:not([disabled]) {
          &:is([open], [checked])
            > :is(
              .toolbarbutton-icon,
              .toolbarbutton-text,
              .toolbarbutton-badge-stack
            ) {
            fill: ${bg.h};
          }
        }
    }

    .identity-color-blue {
        --identity-tab-color: ${blue.h} !important;
        --identity-icon-color: ${blue.h} !important;
    }

    .identity-color-turquoise {
        --identity-tab-color: ${aqua.h} !important;
        --identity-icon-color: ${aqua.h} !important;
    }

    .identity-color-green {
        --identity-tab-color: ${green.h} !important;
        --identity-icon-color: ${green.h} !important;
    }

    .identity-color-yellow {
        --identity-tab-color: ${yellow.h} !important;
        --identity-icon-color: ${yellow.h} !important;
    }

    .identity-color-orange {
        --identity-tab-color: ${orange.h} !important;
        --identity-icon-color: ${orange.h} !important;
    }

    .identity-color-red {
        --identity-tab-color: ${red.h} !important;
        --identity-icon-color: ${red.h} !important;
    }

    .identity-color-pink {
        --identity-tab-color: ${brown.h} !important;
        --identity-icon-color: ${brown.h} !important;
    }

    .identity-color-purple {
        --identity-tab-color: ${purple.h} !important;
        --identity-icon-color: ${purple.h} !important;
    }

    #zen-appcontent-navbar-container {
        background-color: ${t1.h} !important;
    }
}
''
