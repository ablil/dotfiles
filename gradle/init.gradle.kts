// Global test output for every Gradle 9+ build: failed and skipped tests with full
// stack traces, plus one summary line per test task.

import org.gradle.api.tasks.testing.Test
import org.gradle.api.tasks.testing.TestDescriptor
import org.gradle.api.tasks.testing.TestListener
import org.gradle.api.tasks.testing.TestResult
import org.gradle.api.tasks.testing.logging.TestExceptionFormat
import org.gradle.util.GradleVersion

if (GradleVersion.current() >= GradleVersion.version("9.0")) {
    allprojects {
        tasks.withType<Test>().configureEach {
            // Captured at configuration time so the listener stays serializable
            // for the configuration cache.
            val taskPath = path
            val taskLogger = logger

            testLogging {
                events("failed", "skipped")
                exceptionFormat = TestExceptionFormat.FULL
            }

            addTestListener(
                object : TestListener {
                    // The empty overrides are required to compile against Gradle 8's
                    // TestListener, which has no default methods; the version check
                    // above only stops the script from running there.
                    override fun beforeSuite(suite: TestDescriptor) {}

                    override fun beforeTest(testDescriptor: TestDescriptor) {}

                    override fun afterTest(testDescriptor: TestDescriptor, result: TestResult) {}

                    override fun afterSuite(suite: TestDescriptor, result: TestResult) {
                        if (suite.parent == null && result.testCount > 0) {
                            taskLogger.lifecycle(
                                "$taskPath: ${result.testCount} tests, " +
                                    "${result.successfulTestCount} passed, " +
                                    "${result.failedTestCount} failed, " +
                                    "${result.skippedTestCount} skipped",
                            )
                        }
                    }
                },
            )
        }
    }
}

allprojects {
    plugins.withId("java") {
        tasks.register("printClasspath") {
            group = "help"
            description = "Prints the main runtime classpath, one entry per line."

            // Declared as an input and read from a provider so the configuration cache
            // stores the resolved files instead of resolving them during execution.
            val runtimeClasspath = configurations.named("runtimeClasspath")
            inputs.files(runtimeClasspath)
            val classpathEntries = runtimeClasspath.map { it.files.map(File::getAbsolutePath) }

            doLast { classpathEntries.get().forEach(::println) }
        }
    }
}
