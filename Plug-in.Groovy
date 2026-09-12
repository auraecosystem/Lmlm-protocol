plugins {
    id 'groovy'
    id 'io.ratpack.ratpack-groovy' version '1.9.0'
}

repositories {
    mavenCentral()
}

dependencies {
    implementation 'io.ratpack:ratpack-groovy:1.9.0'
    implementation 'org.apache.groovy:groovy-all:4.0.12'
    implementation 'com.github.bancolombia:liqp:0.8.2' // Liquid template engine for Java/JVM
    runtimeOnly 'org.slf4j:slf4j-simple:2.0.7'
}
