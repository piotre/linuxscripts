// ==UserScript==
// @name        time total hidden
// @namespace   toggl.com
// @include     https://www.toggl.com/*
// @version     1
// @grant       GM_addStyle
// ==/UserScript==

GM_addStyle ( ".has-children .col-total {display: none;}" );
