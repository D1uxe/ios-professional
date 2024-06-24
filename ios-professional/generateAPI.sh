MODULE="Modules/NetworkAPI/Sources/NetworkAPI/"
openapi-generator generate --input-spec "newsapi.yaml" --generator-name swift5 --additional-properties=responseAs=AsyncAwait --output "newsAPI"
rm -r $MODULE""*
cp -R "newsAPI/OpenAPIClient/Classes/OpenAPIs/". $MODULE
rm -r "newsAPI"
