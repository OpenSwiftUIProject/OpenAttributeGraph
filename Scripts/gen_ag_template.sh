#!/bin/bash

# A `realpath` alternative using the default C implementation.
filepath() {
  [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

gen_interface() {
  swift build -c release -Xswiftc -emit-module-interface -Xswiftc -enable-library-evolution -Xswiftc -no-verify-emitted-module-interface -Xswiftc -package-name -Xswiftc OpenAttributeGraph -Xswiftc -Osize

  mkdir -p .ag_template
  cp .build/release/Modules/OpenAttributeGraph.swiftinterface .ag_template/template.swiftinterface

  sed -i '' '1,4d' .ag_template/template.swiftinterface
  sed -i '' 's/@_exported public import OpenAttributeGraphCxx/@_exported public import AttributeGraph/g' .ag_template/template.swiftinterface
  sed -i '' 's/OpenAttributeGraphCxx\.//g' .ag_template/template.swiftinterface
  sed -i '' 's/OpenAttributeGraph/AttributeGraph/g' .ag_template/template.swiftinterface
  sed -i '' 's/OPENATTRIBUTEGRAPH/ATTRIBUTEGRAPH/g' .ag_template/template.swiftinterface
  sed -i '' 's/OAG/AG/g' .ag_template/template.swiftinterface

  echo "Generated template.swiftinterface successfully"
}

gen_header() {
  mkdir -p .ag_template/Headers
  
  cp -r Sources/OpenAttributeGraphCxx/include/OpenAttributeGraph/* .ag_template/Headers/
  
  # Rename files from OAGxx to AGxx and OpenAttributeGraphxx to AttributeGraphxx
  find .ag_template/Headers -name "OAG*" -type f | while read file; do
    new_name=$(echo "$file" | sed 's/OAG/AG/g')
    mv "$file" "$new_name"
  done
  
  find .ag_template/Headers -name "OpenAttributeGraph*" -type f | while read file; do
    new_name=$(echo "$file" | sed 's/OpenAttributeGraph/AttributeGraph/g')
    mv "$file" "$new_name"
  done
  
  # Update content in all header files
  find .ag_template/Headers -name "*.h" -type f | while read file; do
    sed -i '' 's/OpenAttributeGraphCxx/AttributeGraph/g' "$file"
    sed -i '' 's/OpenAttributeGraph/AttributeGraph/g' "$file"
    sed -i '' 's/OPENATTRIBUTEGRAPH/ATTRIBUTEGRAPH/g' "$file"
    sed -i '' 's/OAG/AG/g' "$file"
  done
  
  echo "Generated template headers successfully"
}

OPENATTRIBUTEGRAPH_ROOT="$(dirname $(dirname $(filepath $0)))"

cd $OPENATTRIBUTEGRAPH_ROOT

gen_interface
gen_header
