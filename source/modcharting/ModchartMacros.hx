package modcharting;

import haxe.macro.Compiler;
#if macro
import haxe.macro.Context;
import haxe.macro.Expr.Field;
#end

@:publicFields
class ModchartMacros
{
    #if macro
    static macro function registerEases():Array<Field>
    {
        var fields = Context.getBuildFields();
        var list = [];

        for (field in fields)
        {
            var ignore = false;
            if (field.meta != null)
            {
				for(m in field.meta)
                {
                    // just in case
					if (m.name == ":ignore")
					{
                        ignore = true;
                        continue;
                    }
                }
            }

            if (ignore)
                continue;

            list.push(field.name.toLowerCase());
        }
        fields.push({
            name: 'easeList',
            access: [APublic, AStatic],
            kind: FVar(macro:Array<String>, macro $v{list}),
            pos: Context.currentPos()
        });

        Context.info(list.toString(), Context.currentPos());

        return fields;
    }
    #end
}