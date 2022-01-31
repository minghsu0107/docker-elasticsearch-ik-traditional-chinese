
# Docker for Elasticsearch with IK Analyzer and Traditional Chinese
It is such a pain to configure IK Analyzer for Traditional Chinese. Thus, this repository provides a properly configured Docker image for Elasticsearch with IK Analysis plugin and Traditional Chinese dictionaries.
## Usage
```bash
docker run --rm -p 9200:9200 -e "discovery.type=single-node" --memory 5G minghsu0107/elasticsearch-chinese:7.16.2
```
## Test Simplified Chinese
create an index:
```bash
curl -XPUT http://localhost:9200/index0
```
Create a mapping:
```bash
curl -XPOST http://localhost:9200/index0/_mapping -H 'Content-Type:application/json' -d'
{
        "properties": {
            "content": {
                "type": "text",
                "analyzer": "ik_max_word",
                "search_analyzer": "ik_smart"
            }
        }

}'
```
Index some docs:
```bash
curl -XPOST http://localhost:9200/index0/_create/1 -H 'Content-Type:application/json' -d'
{"content":"美国留给伊拉克的是个烂摊子吗"}
'
curl -XPOST http://localhost:9200/index0/_create/2 -H 'Content-Type:application/json' -d'
{"content":"公安部：各地校车将享最高路权"}
'
curl -XPOST http://localhost:9200/index0/_create/3 -H 'Content-Type:application/json' -d'
{"content":"中韩渔警冲突调查：韩警平均每天扣1艘中国渔船"}
'
curl -XPOST http://localhost:9200/index0/_create/4 -H 'Content-Type:application/json' -d'
{"content":"中国驻洛杉矶领事馆遭亚裔男子枪击 嫌犯已自首"}
'
```
Query with highlighting:
```bash
curl -XPOST http://localhost:9200/index0/_search  -H 'Content-Type:application/json' -d'
{
    "query" : { "match" : { "content" : "中国" }},
    "highlight" : {
        "pre_tags" : ["<tag1>", "<tag2>"],
        "post_tags" : ["</tag1>", "</tag2>"],
        "fields" : {
            "content" : {}
        }
    }
}
'
```
## Test Traditional Chinese
create an index:
```bash
curl -XPUT http://localhost:9200/index1
```
Create a mapping:
```bash
curl -XPOST http://localhost:9200/index1/_mapping -H 'Content-Type:application/json' -d'
{
        "properties": {
            "content": {
                "type": "text",
                "analyzer": "ik_max_word",
                "search_analyzer": "ik_smart"
            }
        }

}'
```
Index some docs:
```bash
curl -XPOST http://localhost:9200/index1/_create/1 -H 'Content-Type:application/json' -d'
{"content":"陸美貿易戰已變成科技戰甚至正開打貨幣戰"}
'
curl -XPOST http://localhost:9200/index1/_create/2 -H 'Content-Type:application/json' -d'
{"content":"美國2年期公債殖利率與10年期殖利率利差上周出現倒掛"}
'
curl -XPOST http://localhost:9200/index1/_create/3 -H 'Content-Type:application/json' -d'
{"content":"用露營車產業來判斷美國經濟是否出現衰退，比經濟學家的預測更精準。"}
'
curl -XPOST http://localhost:9200/index1/_create/4 -H 'Content-Type:application/json' -d'
{"content":"被視為判斷美國經濟是否走向衰退的另一指標「露營車」出貨量也明顯下滑"}
'
```
Query:
```bash
curl -XPOST http://localhost:9200/index1/_search  -H 'Content-Type:application/json' -d'
{
    "query" : { "match" : { "content" : "美國" }},
    "highlight" : {
        "pre_tags" : ["<tag1>", "<tag2>"],
        "post_tags" : ["</tag1>", "</tag2>"],
        "fields" : {
            "content" : {}
        }
    }
}
'
```
## Reference
- https://github.com/medcl/elasticsearch-analysis-ik
- https://github.com/sunghau/elasticsearch-analysis-ik-config-traditional-chinese
- https://github.com/jimliu7434/Diary/issues/22