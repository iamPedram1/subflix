export const subdlMovieResponse = {
  status: true,
  statusCode: 200,
  subtitles: [
    {
      subtitle_id: 'subdl-1',
      movie_name: 'Inception',
      release_name: 'Inception.2010.1080p.BluRay.x264-GRP',
      language: 'EN',
      language_name: 'English',
      hearing_impaired: true,
      downloads: 1200,
      rating: 4.8,
      uploader: 'alice',
      year: 2010,
      url: 'https://subdl.com/subtitle/subdl-1',
    },
  ],
};

export const podnapisiSearchHtml = `
<table>
  <tbody>
    <tr class="subtitle-entry" data-href="/en/subtitles/en-inception-2010/pdQ8">
      <td>
        <a alt="Subtitles' page" href="/en/subtitles/en-inception-2010/pdQ8">
          Inception (2010)
        </a>
        <span class="flags">
          <i class="flag fa fa-cc"></i>
        </span>
        <span class="release" title="Inception 2010 1080p BluRay x264-GRP">
          Inception 2010 1080p BluRay x264-GRP
        </span>
      </td>
      <td>23.976</td>
      <td>1</td>
      <td>
        <abbr class="language language-type-short language-en" data-title="English">
          <span>en</span>
        </abbr>
      </td>
      <td>Anonymous</td>
      <td>15749</td>
      <td>0</td>
      <td>
        <div data-title="80.0% (4)" class="progress rating"></div>
      </td>
      <td>
        <span>5/31/15</span>
      </td>
    </tr>
  </tbody>
</table>
`;

export const tvSubsSearchHtml = `
<div class="left">
  <div class="left_articles">
    <ul style="margin-left:2em">
      <li style="font-size: 120%; font-weight:bold; margin:10px 0">
        <div>
          <a href="/tvshow-133.html">Breaking Bad (2008-2013)</a>
        </div>
      </li>
    </ul>
  </div>
</div>
`;

export const tvSubsSeasonHtml = `
<table id="table5">
  <tr align="middle" bgcolor="#ffffff">
    <td>5x16</td>
    <td align="left" style="padding: 0 4px;">
      <a href="episode-45458.html"><b>Felina</b></a>
    </td>
    <td>9</td>
    <td>
      <nobr>
        <a href="subtitle-248324.html">
          <img src="images/flags/en.gif" width="18" height="12" alt="en" border="0" />
        </a>
        <a href="subtitle-248344.html">
          <img src="images/flags/fr.gif" width="18" height="12" alt="fr" border="0" />
        </a>
      </nobr>
    </td>
  </tr>
</table>
`;
