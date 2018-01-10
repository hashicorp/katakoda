document.styleSheets[0].insertRule("@media only screen and (min-width : 992px) { .desktop-only { display:block !important; } .mobile-only { display:none !important; } }","");
document.styleSheets[0].insertRule("@media only screen and (max-width : 991px) { .desktop-only { display:none !important; } .mobile-only { display:block !important; } }","");
