import ratpack.groovy.template.MarkupTemplateModule
import static ratpack.groovy.Groovy.ratpack
import liqp.Template
import groovy.json.JsonSlurper

ratpack {
    handlers {
        get {
            def slurper = new JsonSlurper()
            
            def summaryFile = new File("data/summary.json")
            def metricsFile = new File("data/metrics.json")
            
            def summaryData = summaryFile.exists() ? slurper.parse(summaryFile) : []
            def mlMetrics = metricsFile.exists() ? slurper.parse(metricsFile) : [:]

            def templateFile = new File("src/main/ratpack/templates/index.liquid")
            def template = Template.parse(templateFile)
            
            // Pass both datasets into the Liquid rendering engine
            def renderedHtml = template.render([
                "results": summaryData,
                "metrics": mlMetrics
            ])

            response.send("text/html", renderedHtml)
        }
    }
}
