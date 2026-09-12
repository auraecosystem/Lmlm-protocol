import ratpack.groovy.template.MarkupTemplateModule
import static ratpack.groovy.Groovy.ratpack
import liqp.Template
import groovy.json.JsonSlurper

ratpack {
    handlers {
        get {
            // Read processed metrics from PySpark ETL output
            def jsonFile = new File("data/summary.json")
            def data = jsonFile.exists() ? new JsonSlurper().parse(jsonFile) : []

            // Render via Liquid template
            def templateFile = new File("src/main/ratpack/templates/index.liquid")
            def template = Template.parse(templateFile)
            def renderedHtml = template.render("results", data)

            response.send("text/html", renderedHtml)
        }
    }
}
