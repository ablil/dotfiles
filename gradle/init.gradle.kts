val springProperties = setOf(
    "--spring.main.banner-mode=off",
    "--spring.output.ansi.enabled=always",
    "--logging.include-application-name=false",
    "--logging.level.org.springframework.security=debug",
    "--logging.level.net.payback=debug",
    "--logging.level.com.github.ablil=debug",
    "--logging.pattern.dateformat=HH:mm:ss.SSS"
)

val springSystemProperties = mapOf(
    "hibernate.generate_statistics" to "true",
    "hibernate.show_sql" to "true",
    "hibernate.format_sql" to "true"
)

allprojects {
    afterEvaluate {
        if (pluginManager.hasPlugin("org.springframework.boot") ) {
            tasks.named<JavaExec>("bootRun") {
                args(springProperties)
                systemProperties(springSystemProperties)
            }
        }
    }
}
