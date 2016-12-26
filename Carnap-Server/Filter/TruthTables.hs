module Filter.TruthTables
        (makeTruthTables)
    where

import Text.Pandoc
import Prelude

makeTruthTables :: Block -> Block
makeTruthTables cb@(CodeBlock (_,classes,_) contents)
    | "TruthTable" `elem` classes = Div ("problem",[],[]) $ map (activate classes) (lines contents)
    | otherwise = cb
makeTruthTables x = x

activate cls cnt
    | "Simple" `elem` cls = RawBlock "html" $ 
        "<div class=\"exercise\">"
        ++ "<span> exercise " ++ numof cnt ++ "</span>"
        ++ "<div class=\"truthtable simple\"><div></div><div>" 
        ++ cnt ++ "</div></div></div>"
    | "Validity" `elem` cls = RawBlock "html" $ 
        "<div class=\"exercise\">"
        ++ "<span> exercise " ++ numof cnt ++ "</span>"
        ++ "<div class=\"truthtable validity\"><div></div><div>" 
        ++ cnt ++ "</div></div></div>"
    | otherwise = RawBlock "html" "<div>No Matching TruthTable</div>"
    where numof x = takeWhile (/= ' ') x