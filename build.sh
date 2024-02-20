#!/bin/bash
cat <<EOF > sad-songs.html
<html>
  <head>
    <title>Href Attribute Example</title>
  </head>
  <body>
<table>
  <tr>
    <th>Song</th>
    <th>Year</th>
    <th>Author</th>
    <th>Genre</th>
    <th>YouTube</th>
    <th>Based On</th>
    <th>Description/Spoiler</th>
  </tr>
EOF

while IFS=$'\t' read -r song year author genre youtube based_on desc
do
  [ "$song" == "song" ] && continue # header
  echo "song: $song ($year), author: $author, genre: $genre, yt: $youtube, based_on: $based_on, desc: $desc"


cat <<EOF >> sad-songs.html
  <tr>
    <td>$song</td>
    <td>$year</td>
    <td>$author</td>
    <td>$genre</td>
    <td><a href="$youtube">YouTube</a></td>
    <td><a href="$based_on">Based On</a></td>
    <td>
      <details>
        <summary>Spoiler</summary>
        $desc
      </details>
    </td>
  </tr>
EOF

done < sad-songs.tsv

cat <<EOF >> sad-songs.html
    </table>
    <br/>
    <p>Built from / contribute to: <a href="https://github.com/moparisthebest/sad-songs">github</a> or <a href="https://code.moparisthebest.com/moparisthebest/sad-songs">code.moparisthebest.com</a></p>
  </body>
</html>
EOF

rsync -avz --stats --progress sad-songs.html moparisthebest.com:/htdocs/moparisthebest.com/
