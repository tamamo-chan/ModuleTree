/*
 * generated by Xtext 2.25.0
 */
package dk.sdu.tamamo.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import dk.sdu.tamamo.moduleTree.Decision
import dk.sdu.tamamo.moduleTree.Input
import dk.sdu.tamamo.moduleTree.Rules
import dk.sdu.tamamo.moduleTree.Conclusion
import dk.sdu.tamamo.moduleTree.Start
import dk.sdu.tamamo.moduleTree.Parameter
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.xmi.impl.XMLResourceImpl
import org.eclipse.emf.ecore.util.EcoreUtil
import dk.sdu.tamamo.moduleTree.ParentTree
import dk.sdu.tamamo.moduleTree.InputInt
import dk.sdu.tamamo.moduleTree.InputString
import dk.sdu.tamamo.moduleTree.TreeType
import dk.sdu.tamamo.moduleTree.ChildTree
import dk.sdu.tamamo.moduleTree.DecisionNormal
import dk.sdu.tamamo.moduleTree.DecisionNested
import java.util.List
import java.util.ArrayList
import dk.sdu.tamamo.moduleTree.RuleTypeExp
import dk.sdu.tamamo.moduleTree.RuleType
import dk.sdu.tamamo.moduleTree.Expression
import dk.sdu.tamamo.moduleTree.Plus
import dk.sdu.tamamo.moduleTree.Minus
import dk.sdu.tamamo.moduleTree.Mult
import dk.sdu.tamamo.moduleTree.Div
import dk.sdu.tamamo.moduleTree.RuleTypeID
import dk.sdu.tamamo.moduleTree.Operator
import dk.sdu.tamamo.moduleTree.GreaterThan
import dk.sdu.tamamo.moduleTree.LessThan
import dk.sdu.tamamo.moduleTree.GreaterEqual
import dk.sdu.tamamo.moduleTree.RulesConclude
import dk.sdu.tamamo.moduleTree.EffectType
import dk.sdu.tamamo.moduleTree.RulesChange
import dk.sdu.tamamo.moduleTree.Subtract

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class ModuleTreeGenerator extends AbstractGenerator {

	override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
		val Start startModel = resource.allContents.filter(Start).next
		
		System::out.println("Anything")
		
		codegenBegin(fsa, startModel, resource)
	}
	
	def generatePackage() {
		'''
			package decisiontree;
		'''
	}
	
	def codegenBegin(IFileSystemAccess2 fsa, Start start, Resource resource) {
		val tree = start.getParent
		generateTree(fsa, tree, resource)
	}
	
	def generateTree(IFileSystemAccess2 fsa, ParentTree tree, Resource resource) {
		tree.generateInputFile(fsa, resource)
		tree.generateDecisionFile(fsa, resource)
		tree.generateParameterFile(fsa, resource)
		tree.generateRulesFile(fsa, resource)
		tree.generateConclusionFile(fsa, resource)
		//startModel.generateStartFile(fsa)
	}
	
	def void generateConclusionFile(ParentTree tree, IFileSystemAccess2 fsa, Resource resource) {
		fsa.generateFile('''decisiontree/??tree.getModule_name.toFirstUpper??Conclusion.java''', generateConclusion(tree, resource))
		
		if (tree.next !== null) (tree.next as TreeType).generateConclusionFile(fsa, resource)
	}
	
	def void generateConclusionFile(TreeType tree, IFileSystemAccess2 fsa, Resource resource) {
		fsa.generateFile('''decisiontree/??tree.getModule_name.toFirstUpper??Conclusion.java''', generateConclusion(tree, resource))
		
		if (tree.next !== null) (tree.next as TreeType).generateConclusionFile(fsa, resource)
	}
	
	def CharSequence generateConclusion(TreeType tree, Resource resource) {
		var CharSequence chars = 
		'''
		??generatePackage()??
		
		import java.util.ArrayList;
		import java.util.List;
		public class Conclusion {
			
			??tree.module_name.toFirstUpper??Decision ??tree.module_name.toFirstLower??_decision = new ??tree.module_name.toFirstUpper??Decision();
			??tree.module_name.toFirstUpper??Parameter ??tree.module_name.toFirstLower??_param = new ??tree.module_name.toFirstUpper??Parameter();
			'''
			
		switch tree {
			ParentTree : 
			chars = chars + 
		'''
			public List<String> begin(??tree.module_name.toFirstUpper??Input ??tree.module_name.toFirstLower??_input) {
			
			??tree.module_name.toFirstUpper??Rules ??tree.module_name.toFirstLower??_rule = new ??tree.module_name.toFirstUpper??Rules(??tree.module_name.toFirstLower??_input, ??tree.module_name.toFirstLower??_param);
			List<String> ??tree.module_name.toFirstLower??_nested = new ArrayList<>();
			
			String ??tree.module_name.toFirstLower??_response = ??tree.module_name.toFirstLower??_rule.setupRules();
			
			if (??tree.module_name.toFirstLower??_response != null) {
				??tree.module_name.toFirstLower??_nested.add(response);
				return ??tree.module_name.toFirstLower??_nested;
			}
			
			??generateBegin(tree)??
			}
		}
		'''
		}
		
	}
	
	def generateBegin(TreeType tree) {
		
	}
		
	
	
	def void generateRulesFile(ParentTree tree, IFileSystemAccess2 fsa, Resource resource) {
		fsa.generateFile('''decisiontree/??tree.getModule_name.toFirstUpper??Rules.java''', generateRules(tree, resource))
		
		if (tree.next !== null) (tree.next as TreeType).generateRulesFile(fsa, resource)
	}
	
	def void generateRulesFile(TreeType tree, IFileSystemAccess2 fsa, Resource resource) {
		fsa.generateFile('''decisiontree/??tree.getModule_name.toFirstUpper??Rules.java''', generateRules(tree, resource))
		
		if (tree.next !== null) (tree.next as TreeType).generateRulesFile(fsa, resource)
	}
	
	def CharSequence generateRules(TreeType tree, Resource resource) {
		
		var ParentTree parent = null
		
		if (tree instanceof ChildTree ) {
			parent = findParentClass(tree, resource)
		}
		
		
		var CharSequence chars = ''''''
		
		switch tree {
			ParentTree : 
			chars = chars + '''
			??generatePackage()??
			
			public class ??tree.module_name.toFirstUpper??Rules {
				??tree.module_name.toFirstUpper??Parameter ??tree.module_name.toFirstLower??_param = null;
				??tree.module_name.toFirstUpper??Input ??tree.module_name.toFirstLower??_input = null;
				??tree.module_name.toFirstUpper??Decision ??tree.module_name.toFirstLower??_decision = new ??tree.module_name.toFirstUpper??Decision();
				
				public ??tree.module_name.toFirstUpper??Rules(??tree.module_name.toFirstUpper??Input ??tree.module_name.toFirstLower??_input, ??tree.module_name.toFirstUpper??Parameter ??tree.module_name.toFirstLower??_param) {
					this.??tree.module_name.toFirstLower??_input = ??tree.module_name.toFirstLower??_input;
					this.??tree.module_name.toFirstLower??_param = ??tree.module_name.toFirstLower??_param;
				}
				
				
				public String setupRules() {
					
					??generateInputBody(tree.rules, tree.module_name)??
					
					return null;
				}
			}'''
			
			ChildTree : 
			chars = chars + '''
			??generatePackage()??
			
			public class ??tree.module_name.toFirstUpper??Rules extends ??tree.parent.toFirstUpper??Rules {
				??tree.module_name.toFirstUpper??Parameter ??tree.module_name.toFirstLower??_param = null;
				??tree.module_name.toFirstUpper??Input ??tree.module_name.toFirstLower??_input = null;
				??tree.module_name.toFirstUpper??Decision ??tree.module_name.toFirstLower??_decision = new ??tree.module_name.toFirstUpper??Decision();
				
				public ??tree.module_name.toFirstUpper??Rules(??parent.generateConstructor??, ??tree.module_name.toFirstUpper??Input ??tree.module_name.toFirstLower??_input, ??tree.module_name.toFirstUpper??Parameter ??tree.module_name.toFirstLower??_param) {
					super(??parent.module_name.toFirstLower??_input, ??parent.module_name.toFirstLower??_param);
					this.??tree.module_name.toFirstLower??_input = ??tree.module_name.toFirstLower??_input;
					this.??tree.module_name.toFirstLower??_param = ??tree.module_name.toFirstLower??_param;
				}
				
				
				public String setupRules() {
					super.setupRules();
					
					??setupRules(tree)??
					
					return null;
				}
			}'''
			
			}
		
		return chars
			
		
	}
	
	def setupRules(ChildTree tree) {
		generateComp(tree, tree.rules)
		
	}
	
	def CharSequence generateComp(ChildTree child, Rules rule) {
		val RuleType left = rule.left
		var CharSequence chars = '''if ('''
		switch left {
			RuleTypeExp : chars = chars + left.exp.compute.toString + ''' '''
			RuleTypeID :  
			if (checkBelonging(child.input, left)) {
				chars = chars + '''??child.module_name.toFirstLower??_input.get??left.name.toFirstUpper??() '''	
			} else {
				chars = chars + '''??child.parent.toFirstLower??_input.get??left.name.toFirstUpper??() '''
			}
			
			default: println("error")
		}
		
		val Operator op = rule.operator
		if (op !== null) {
			chars = chars + op.type + ''' '''
		}
		
		val RuleType right = rule.right
		switch right {
			RuleTypeExp : chars = chars + right.exp.compute.toString + ''' '''
			RuleTypeID :  
			if (checkBelonging(child.input, right)) {
				chars = chars + '''??child.module_name.toFirstLower??_input.get??right.name.toFirstUpper??() '''	
			} else {
				chars = chars + '''??child.parent.toFirstLower??_input.get??right.name.toFirstUpper??() '''
			}
			default: println("error")
		}
		
		chars = chars + 
		
''') {
	??generateEffect(child, rule)??
}

??IF rule.next !== null????generateComp(child, rule.next)????ENDIF??'''
		
		
		return chars
	}
	
	def checkBelonging(Input input, RuleTypeID rule) {
		var Input current = input
		do {
			
			if (current.value.name.equals(rule.name)) {
				return true
			}
			
		} while ((current = current.next) !== null)
		return false
	}
	
	def checkBelonging(Decision decision, RulesConclude effect) {
		var Decision current = decision
		do {
			
			if (decision.text.equals(effect.decision)) {
				return true
			}
			
		} while ((current = current.next) !== null)
		return false
	}
	
	def checkBelonging(Parameter param, RulesChange effect) {
		var Parameter current = param
		do {
			
			if (param.name.equals(effect.affected_parameter)) {
				return true
			}
			
		} while ((current = current.next) !== null)
		return false
	}
	
	def generateEffect(ChildTree child, Rules rule) {
		var CharSequence chars = ''''''
		val EffectType effect = rule.effect
		switch effect {
			RulesConclude : 
			if (checkBelonging(child.decision, effect)) {
				chars = chars + '''return ??child.module_name.toFirstLower??_decision.get??effect.decision.toFirstUpper??();'''
			} else {
				chars = chars + '''return ??child.parent.toFirstLower??_decision.get??effect.decision.toFirstUpper??();'''
			}
			RulesChange : 
			
			if (!checkBelonging(child.parameter, effect)) {
				chars = chars  + 
				'''??child.module_name.toFirstLower??_param.set??effect.affected_parameter.toFirstUpper??(??child.module_name.toFirstLower??_param.get??
				effect.affected_parameter.toFirstUpper??() ??IF effect.points instanceof Subtract??- ??ELSE??+ ??ENDIF????effect.points.points??);''' 
			} else {
				chars = chars  + 
			'''??child.parent.toFirstLower??_param.set??effect.affected_parameter.toFirstUpper??(??child.parent.toFirstLower??_param.get??
			effect.affected_parameter.toFirstUpper??() ??IF effect.points instanceof Subtract??- ??ELSE??+ ??ENDIF????effect.points.points??);''' 
			}
			
			
		}
		return chars
	}
	
	
	




// TODO: Fix this mess to account for different class names

	def CharSequence generateInputBody(TreeType tree) {
		generateInputBody(tree.rules, tree.module_name)
	}
	
	def CharSequence generateInputBody(Rules rule, String name) {
		'''
		if ( ??generateComparison(rule, name)?? ) {
			??rule.generateEffect(name)??
		}
		
		??IF rule.getNext !== null????generateInputBody(rule.getNext, name)????ENDIF??
		'''
	}
	
	def CharSequence generateEffect(Rules rules, String name) {
		var CharSequence chars = ''''''
		val EffectType effect = rules.effect
		switch effect {
			RulesConclude : chars = chars + '''return ??name.toFirstLower??_decision.get??effect.decision.toFirstUpper??();'''
			RulesChange : chars = chars  + 
			'''??name.toFirstLower??_param.set??effect.affected_parameter.toFirstUpper??(??name.toFirstLower??_param.get??
			effect.affected_parameter.toFirstUpper??() ??IF effect.points instanceof Subtract??- ??ELSE??+ ??ENDIF????effect.points.points??);''' 
		}
		return chars
	}
	
	def CharSequence generateComparison(Rules rule, String name) {
		val RuleType left = rule.left
		var CharSequence chars = ''''''
		switch left {
			RuleTypeExp : chars = chars + left.exp.compute.toString + ''' '''
			RuleTypeID :  chars = chars + '''??name.toFirstLower??_input.get??left.name.toFirstUpper??() '''
			default: println("error")
		}
		
		val Operator op = rule.operator
		if (op !== null) {
			chars = chars + op.type + ''' '''
		}
		
		val RuleType right = rule.right
		switch right {
			RuleTypeExp : chars = chars + right.exp.compute.toString + ''' '''
			RuleTypeID :  chars = chars + '''??name.toFirstLower??_input.get??right.name.toFirstUpper??() '''
			default: println("error")
		}
		
		
		return chars
		
	}
	
	def static int compute(Expression math) { 
			math.computeExp
	//		math.exp.computeExpEnv(new HashMap<String,Integer>)
		}
		
	// Normal style using xtext binding, requires a scope provider
	def static int computeExp(Expression exp) {
		switch exp {
			Plus: exp.left.computeExp+exp.right.computeExp
			Minus: exp.left.computeExp-exp.right.computeExp
			Mult: exp.left.computeExp*exp.right.computeExp
			Div: exp.left.computeExp/exp.right.computeExp
			dk.sdu.tamamo.moduleTree.Number: exp.value
			default: throw new Error("Internal error")
		}
	}	
	
	def void generateParameterFile(ParentTree tree, IFileSystemAccess2 fsa, Resource resource) {
		fsa.generateFile('''decisiontree/??tree.getModule_name.toFirstUpper??Parameter.java''', generateParameterParent(tree))
		
		if (tree.next !== null) (tree.next as TreeType).generateParameterFile(fsa, resource)
	}
	
	def void generateParameterFile(TreeType tree, IFileSystemAccess2 fsa, Resource resource) {
		fsa.generateFile('''decisiontree/??tree.getModule_name.toFirstUpper??Parameter.java''', generateParameter(tree, resource))
		
		if (tree.next !== null) tree.next.generateParameterFile(fsa, resource)
	}
	
	def CharSequence generateParameter(TreeType tree, Resource resource) {
		switch tree {
			ParentTree: generateParameterParent(tree)
			ChildTree: generateParameterChild(tree, resource)
			default: '''error'''
		}
	}
	
	def generateParameterChild(ChildTree tree, Resource resource) {
		val ParentTree parent = findParentClass(tree, resource)
		'''
		??generatePackage()??
		public class ??tree.module_name.toFirstUpper??Parameter extends ??tree.parent.toFirstUpper??Parameter {
			
			??generateClassVariables(tree, parent)??
			
			public ??tree.getModule_name.toFirstUpper??Parameter(??generateConstructorParameters(tree, parent)??) {
				??getSuperNames(tree, parent)??
				??tree.generateConstructor(parent)??
			}
		}'''
	}
	
	def generateConstructor(ChildTree child, ParentTree parent) {
		val List<Parameter> new_params = getNewParameters(child, parent)
		var CharSequence stuff = ''''''
		
		for (i : 0 ..< new_params.size) {
			stuff = stuff + '''this.??new_params.get(i).name?? = ??new_params.get(i).name??;
			'''
		}
		return stuff
	}
	
	def generateConstructorParameters(ChildTree child, ParentTree parent) {
		val List<Parameter> new_params = getNewParameters(child, parent)
		var CharSequence stuff = ''''''
		
		for (i : 0 ..< new_params.size) {
			stuff = stuff + '''int ??new_params.get(i).name??'''
			if (i != new_params.size - 1) {
				stuff = stuff + ''', '''
			}
		}
		
		return stuff
	}
	
	def getSuperNames(ChildTree child, ParentTree parent) {
		var Parameter current_parent = parent.parameter
		var Parameter current_child = child.parameter
		var List<Integer> array = new ArrayList
		
		do {
			var boolean found = false
			do {
				if (current_parent.name.equals(current_child.name)) {
					found = true
					array.add(current_child.value)
				}
			} while ((current_child = current_child.next) !== null && !found)
			
			if (!found) {
				array.add(current_parent.value)
			}
			
			current_child = child.parameter
		} while ((current_parent = current_parent.next) !== null)
		
		var CharSequence superNumbers = ''''''
		
		if (array.size < 1) {
			return superNumbers
		} else {
			superNumbers = superNumbers + '''super('''
		}
		
		for (i : 0 ..< array.size) {
			if (i == array.size - 1) {
				superNumbers = superNumbers + array.get(i).toString
			} else {
				superNumbers = superNumbers + array.get(i).toString + ''', '''
			}
		} return superNumbers + ''');''' 
		
	}
	
	def CharSequence generateParameterParent(ParentTree tree) {
		'''
		??generatePackage()??
		public class ??tree.module_name.toFirstUpper??Parameter {
			??generateClassVariables(tree.parameter)??
			
			public ??tree.getModule_name.toFirstUpper??Parameter(??tree.parameter.generateConstructor??) {
				??generateAssignment(tree.parameter)??
			}
		}'''
	}
	
	def CharSequence generateClassVariables(Parameter param) {
		'''
		private int ??param.name?? = ??param.value??;
		public int get??param.name.toFirstUpper??() {
			return this.??param.name??;
		}
		public void set??param.name.toFirstUpper??(int value) {
			this.??param.name?? = value;
		}
		??IF param.next !== null????generateClassVariables(param.next)????ENDIF??'''
	}
	
	def generateClassVariables(ChildTree child, ParentTree parent) {
		//Find new values for parameters in the child tree, generateClassVariables for these, add it to constructor.
		var List<Parameter> new_parameters = getNewParameters(child, parent)
		var CharSequence stuff = ''''''
		for (i: 0 ..< new_parameters.size) {
			stuff = stuff + new_parameters.get(i).generateChildClassVariable
		}
		
		return stuff
	}
	
	def String generateChildClassVariable(Parameter param) {
		'''
		private int ??param.name?? = ??param.value??;
		public int get??param.name.toFirstUpper??() {
			return this.??param.name??;
		}
		public void set??param.name.toFirstUpper??(int value) {
			this.??param.name?? = value;
		}
		
		'''
	}
	
	
	def getNewParameters(ChildTree child, ParentTree parent) {
		var List<Parameter> new_params = new ArrayList
		var Parameter current_param = child.parameter
		do {
			if (!compareParams(current_param, parent.parameter)) {
				new_params.add(current_param)
			}
		} while ((current_param = current_param.next) !== null)
		
		return new_params
	}
	
	def boolean compareParams(Parameter param1, Parameter param2) {
		if (param1.name.equals(param2.name)) {
			return true
		} else {
			if (param2.next !== null) {
				compareParams(param1, param2.next)
			} else {
				return false
			}
			
		}
	}
	
	def void generateDecisionFile(ParentTree tree, IFileSystemAccess2 fsa, Resource resource) {
		fsa.generateFile('''decisiontree/??tree.getModule_name.toFirstUpper??Decision.java''', generateDecisionParent(tree))
		
		if (tree.next !== null) (tree.next as TreeType).generateDecisionFile(fsa, resource)
	}
	
	def void generateDecisionFile(TreeType tree, IFileSystemAccess2 fsa, Resource resource) {
		fsa.generateFile('''decisiontree/??tree.getModule_name.toFirstUpper??Decision.java''', generateDecision(tree, resource))
		
		if (tree.next !== null) (tree.next as TreeType).generateDecisionFile(fsa, resource)
	}
	
	def CharSequence generateDecision(TreeType tree, Resource resource) {
		switch tree {
			ParentTree: generateDecisionParent(tree)
			ChildTree: generateDecisionChild(tree, resource)
			default: '''error'''
		}
	}
	
	def ParentTree findParentClass(ChildTree tree, Resource resource) {
		var ParentTree parent = null
		for (ParentTree pt : resource.allContents.filter(ParentTree).toIterable) {
			if (pt.module_name.equals(tree.parent)) {
				parent = pt
			}
		} return parent
	}
	
	def generateDecisionChild(ChildTree tree, Resource resource) {
		val ParentTree parent = findParentClass(tree, resource)
		
		'''
		??generatePackage??
		
		import java.util.List;
		import java.util.ArrayList;
		public class ??tree.module_name.toFirstUpper??Decision extends ??parent.module_name.toFirstUpper??Decision {
			
			??tree.decision.generateDecisionVariables??
			
		}
		'''
	}
	
	def CharSequence generateDecisionParent(ParentTree tree) {
		'''
		??generatePackage??
		
		import java.util.List;
		import java.util.ArrayList;
		public class ??tree.module_name.toFirstUpper??Decision {
			
			??tree.decision.generateDecisionVariables??
			
		}
		'''
	}
	
	def CharSequence generateDecisionVariables(Decision decision) {
		switch decision {
			DecisionNormal: 
			'''
			private String _??decision.text?? = "??decision.text??";
			public String get??decision.text.toFirstUpper??() {
				return this._??decision.text??;
			}
			
			??IF (decision.next !== null)????decision.next.generateDecisionVariables????ENDIF??
			'''
			
			DecisionNested: 
			'''
			private ??decision.text.toFirstUpper?? ??decision.text.toFirstLower?? = new ??decision.text.toFirstUpper??();
			
			public ??decision.text.toFirstUpper?? get??decision.text.toFirstUpper??() {
				return this.??decision.text.toFirstLower??;
			}
			
			public class ??decision.text.toFirstUpper?? {
				private List<String> nested_values;
				public List<String> getNestedValues() {
					return this.nested_values;
				}
				
				public ??decision.text.toFirstUpper??() {
					nested_values = new ArrayList<>();
					??decision.nested.generateNestedValues??
				}
			}
			'''
		}
	}
	
	def CharSequence generateNestedValues(Decision decision){
		'''
		nested_values.add("??decision.text??");
		??IF (decision.next !== null)????decision.next.generateNestedValues????ENDIF??
		'''
	}
	
	
	
	def void generateInputFile(ParentTree tree, IFileSystemAccess2 fsa, Resource resource) {
		fsa.generateFile('''decisiontree/??tree.getModule_name.toFirstUpper??Input.java''', generateInputParent(tree))
		
		if (tree.next !== null) (tree.next as TreeType).generateInputFile(fsa, resource)
	}
	
	def void generateInputFile(TreeType tree, IFileSystemAccess2 fsa, Resource resource) {
		fsa.generateFile('''decisiontree/??tree.getModule_name.toFirstUpper??Input.java''', generateInput(tree, resource))
		
		if (tree.next !== null) tree.next.generateInputFile(fsa, resource)
	}
	
	def CharSequence generateInput(TreeType tree, Resource resource) {
		switch tree {
			ParentTree: generateInputParent(tree)
			ChildTree: generateInputChild(tree, resource)
			default: '''error'''
		}
	}
	
	def CharSequence generateInputParent(ParentTree tree) {
		'''
		??generatePackage()??
		public class ??tree.module_name.toFirstUpper??Input {
			
			??generateClassVariables(tree.input)??
			
			public ??tree.module_name??Input(??generateConstructor(tree.input)??) {
				??generateAssignment(tree.input)??
			}	
		}
		'''
	}
	
	def CharSequence generateInputChild(ChildTree tree, Resource resource) {
		var ParentTree parent = findParentClass(tree, resource)
		'''
		??generatePackage()??
		public class ??tree.module_name.toFirstUpper??Input extends ??tree.parent.toFirstUpper??Input {
			
			??generateClassVariables(tree.input)??
			
			public ??tree.module_name??Input(??parent.input.generateConstructor??, ??tree.input.generateConstructor??) {
				super(??parent.input.getSuperNames??);
				??generateAssignment(tree.input)??
			}	
		}
		'''
	}
	
	def CharSequence getSuperNames(EObject object) {
		switch object {
			Input: 
			'''
			??object.value.name????IF (object.next !== null)??, ??object.next.getSuperNames????ENDIF??'''
			
			Parameter:
			'''
			??object.value????IF (object.next !== null)??, ??object.next.getSuperNames????ENDIF??''' 
			
			
		}
	}
	
	def CharSequence generateAssignment(EObject object) {
		switch object {
			Input: '''
			this.??object.value.name?? = ??object.value.name??;
			??IF object.next !== null????generateAssignment(object.next)????ENDIF??'''
			
			Parameter: '''
			this.??object.name?? = ??object.name??;
			??IF object.next !== null????generateAssignment(object.next)????ENDIF??'''
			default: '''error'''
		}
	}
	
	def CharSequence generateConstructor(EObject object) {
		switch object {
			Input: 
			'''??object.generateConstructorType?? ??object.value.name????IF (object.next !== null)??, ??object.next.generateConstructor????ENDIF??'''
			Parameter: '''int ??object.name????IF (object.next !== null)??, ??object.next.generateConstructor????ENDIF??'''
			ParentTree: '''??object.module_name.toFirstUpper??Input ??object.module_name.toFirstLower??_input, ??object.module_name.toFirstUpper??Parameter ??object.module_name.toFirstLower??_param'''
		}
		
	} 
	
	def CharSequence generateConstructorType(Input input) {
		switch input.value {
			InputInt : '''int'''
			InputString: '''String'''
			default: '''boolean'''
		}
	}
	
	def CharSequence generateClassVariables(Input input) {
		'''
		private ??input.generateClassVariablesType??get??input.value.name.toFirstUpper??() {
			return this.??input.value.name??;
		}
		
		??IF (input.next !== null)????input.next.generateClassVariables????ENDIF??''' 
	}
	
	def CharSequence generateClassVariablesType(Input input) {
		switch input.value {
			InputInt: '''
			int ??input.value.name??;
			public int '''
			InputString: '''
			String ??input.value.name??;
			public String '''
			default: '''
			boolean ??input.value.name??;
			public boolean '''
		}
	}

	
	
	
	def void display(EObject obj) {
		val res = new XMLResourceImpl
		res.contents.add(EcoreUtil::copy(obj))
		System::out.println("Dump of model:")
		res.save(System.out,null)
	}
}
