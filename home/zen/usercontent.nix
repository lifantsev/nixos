{ rice, ... }: with rice.col; /* css */ ''
/* Catppuccin Mocha Blue userContent.css*/

@media (prefers-color-scheme: dark) {

  /* Common variables affecting all pages */
  @-moz-document url-prefix("about:") {
    :root {
      --in-content-page-color: ${t7.h} !important;
      --color-accent-primary: ${blue.h} !important;
      --color-accent-primary-hover: ${blue.h} !important;
      --color-accent-primary-active: ${blue.h} !important;
      background-color: #00000000 !important;
      --in-content-page-background: #00000000 !important;
    }

  }

  /* Variables and styles specific to about:newtab and about:home */
  @-moz-document url("about:newtab"), url("about:home") {

    :root {
      --newtab-background-color: #00000000 !important;
      --newtab-background-color-secondary: ${t2.h} !important;
      --newtab-element-hover-color: ${t2.h} !important;
      --newtab-text-primary-color: ${t7.h} !important;
      --newtab-wordmark-color: ${t7.h} !important;
      --newtab-primary-action-background: ${blue.h} !important;
    }

    .icon {
      color: ${blue.h} !important;
    }

    @media (max-width: 609px) {
      .search-wrapper .logo-and-wordmark .logo {
        background-size: 64px !important;
        height: 64px !important;
        width: 64px !important;
      }
    }

    .card-outer:is(:hover, :focus, .active):not(.placeholder) .card-title {
      color: ${blue.h} !important;
    }

    .top-site-outer .search-topsite {
      background-color: ${blue.h} !important;
    }

    .compact-cards .card-outer .card-context .card-context-icon.icon-download {
      fill: ${green.h} !important;
    }
  }

  /* Variables and styles specific to about:preferences */
  @-moz-document url-prefix("about:preferences") {
    :root {
      --zen-colors-tertiary: ${t1.h} !important;
      --in-content-text-color: ${t7.h} !important;
      --link-color: ${blue.h} !important;
      --link-color-hover: rgb(163, 197, 251) !important;
      --zen-colors-primary: ${t2.h} !important;
      --in-content-box-background: ${t2.h} !important;
      --zen-primary-color: ${blue.h} !important;
    }

    groupbox , moz-card{
      background: #00000000 !important;
    }

    button,
    groupbox menulist {
      background: ${t2.h} !important;
      color: ${t7.h} !important;
    }

    .main-content {
      background-color: #00000000 !important;
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
      --identity-tab-color: "${brown.h}" !important;
      --identity-icon-color: "${brown.h}" !important;
    }

    .identity-color-purple {
      --identity-tab-color: ${purple.h} !important;
      --identity-icon-color: ${purple.h} !important;
    }
  }

  /* Variables and styles specific to about:addons */
  @-moz-document url-prefix("about:addons") {
    :root {
      --zen-dark-color-mix-base: ${t1.h} !important;
      --background-color-box: #00000000 !important;
    }
  }

  /* Variables and styles specific to about:protections */
  @-moz-document url-prefix("about:protections") {
    :root {
      --zen-primary-color: #00000000 !important;
      --social-color: ${purple.h} !important;
      --coockie-color: ${aqua.h} !important;
      --fingerprinter-color: ${yellow.h} !important;
      --cryptominer-color: ${blue.h} !important;
      --tracker-color: ${green.h} !important;
      --in-content-primary-button-background-hover: rgb(81, 83, 105) !important;
      --in-content-primary-button-text-color-hover: ${t7.h} !important;
      --in-content-primary-button-background: ${t3.h} !important;
      --in-content-primary-button-text-color: ${t7.h} !important;
    }


    .card {
      background-color: ${t2.h} !important;
    }
  }
}
''
