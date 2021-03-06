/*
 * generated by Xtext 2.10.0
 */
package org.example.school.tests

import com.google.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.xbase.testing.CompilationTestHelper
import org.eclipse.xtext.xbase.testing.TemporaryFolder
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(XtextRunner)
@InjectWith(SchoolInjectorProvider)
class SchoolGeneratorTest {

	@Rule @Inject public TemporaryFolder temporaryFolder
	@Inject extension CompilationTestHelper

	@Test
	def void testSchoolGenerator() {
		'''
			school "A school" {
				student "A student" registrationNum 100 {
					"A teacher"
				}
				student "A student with no teacher" registrationNum 101
				teacher "A teacher"
			}
			school "Another school" {
				teacher "A teacher"
				student "A student" registrationNum 100 {
					"A teacher", "Another teacher"
				}
				teacher "Another teacher"
			}
		'''.assertCompilesTo(
			'''
			school A school
				students number 2
				students with no teacher 1
				teachers number 1
				teachers
					A teacher
				students
					A student registration number 100
						student's teachers
							A teacher
					A student with no teacher registration number 101
						student's teachers
			
			school Another school
				students number 1
				students with no teacher 0
				teachers number 2
				teachers
					A teacher
					Another teacher
				students
					A student registration number 100
						student's teachers
							A teacher
							Another teacher
			'''
		)
	}

}
