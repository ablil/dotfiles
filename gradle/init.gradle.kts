// package with DEBUG log level
val loggingPackages = setOf(
    "com.github.ablil",
    "net.payback",
    "org.springframework.security",
    "org.springframework.web",
)

// custom spring properties
val springProperties = setOf(
    "--spring.main.banner-mode=off",
    "--spring.output.ansi.enabled=always",
    "--logging.include-application-name=false",
    "--logging.pattern.dateformat=HH:mm:ss.SSS",
    "--logging.pattern.console=%clr(%d{HH:mm:ss.SSS}) %clr(%5p) %clr(%-40.40logger{39}){cyan} %m%n", // shorten log pattern
)

val springSystemProperties = mapOf(
    "hibernate.generate_statistics" to "false",
    "hibernate.show_sql" to "false",
    "hibernate.format_sql" to "false"
)

allprojects {
    afterEvaluate {
        if (pluginManager.hasPlugin("org.springframework.boot") ) {
            tasks.named<JavaExec>("bootRun") {
                args(springProperties + loggingPackages.map { "--logging.level.$it=debug" })
                systemProperties(springSystemProperties)
            }
        }
    }
}
