a=$(cat ~/token.gh)
jq '.artifacts[].id' gh-artifacts.json > list-id.txt

while read id; do
    curl -L\
      --output $id.zip \
      -H "Accept: application/vnd.github+zip" \
      -H "Authorization: Bearer $a" \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      https://api.github.com/repos/damermic/R509-graphiz/actions/artifacts/$id/zip

    unzip -o "$id.zip"
    rm $id.zip
done < list-id.txt
