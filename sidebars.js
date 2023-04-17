/**
 * Creating a sidebar enables you to:
 - create an ordered group of docs
 - render a sidebar for each doc of that group
 - provide next/previous navigation

 The sidebars can be generated from the filesystem, or explicitly defined here.

 Create as many sidebars as you want.
 */

// @ts-check

/** @type {import('@docusaurus/plugin-content-docs').SidebarsConfig} */
const sidebars = {
  maps_js_sdk: [
    {
      type: 'autogenerated',
      dirName: 'maps_js_sdk',
    },
  ],
  maps_flutter_sdk: [
    {
      type: 'autogenerated',
      dirName: 'maps_flutter_sdk',
    },
  ],
  geoportal: [
    {
      type: 'autogenerated',
      dirName: 'geoportal',
    },
  ],
  geosurvey: [
    {
      type: 'autogenerated',
      dirName: 'geosurvey',
    },
  ],
  qgis_plugins: [
    {
      type: 'autogenerated',
      dirName: 'qgis_plugins',
    },
  ],
  
};
module.exports = sidebars;
