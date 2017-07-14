### Using process.env

If you do not want to rely on a `.viewport.rc` setting in your home, or need
builds on a CI server, you can use the following `process.env` variables:

* VPRT_THEMENAME - `themeName`
* VPRT_THEMEID - `themeId`
* VPRT_ENV - `env`
* VPRT_CONFLUENCEBASEURL - `target.confluenceBaseUrl`
* VPRT_USERNAME - `target.username`
* VPRT_PASSWORD - `target.password`
* VPRT_SOURCEBASE - `sourceBase`
* VPRT_TARGETPATH - `targetPath`
