��    W      �     �      �  [   �     �  9   �  (   3     \     i  	   y     �  	   �     �     �     �  (   �     	     -	     M	     h	     �	     �	     �	     �	     �	  ,   �	     
  :   6
  1   q
  9   �
  6   �
       "   .  )   Q     {  %   �  #   �  +   �  +     1   /  1   a  %   �  +   �  1   �  1     /   I     y     �     �     �  .   �  +   	     5     O  !   j  5   �  "   �  0   �          &     F  )   c     �     �  %   �  &   �          &  !   :     \  !   w  !   �  2   �  2   �  2   !  0   T  -   �  ;   �  	   �     �                     /     G     b      w     �     �  =  �  Z     !   ]  @     -   �     �     �  	          	   5     ?     U  !   j  3   �     �     �     �       %   1  $   W     |     �     �  8   �     �  ?   
  8   J  >   �  C   �       ,   &  .   S     �  )   �  $   �  6   �  /     :   L  :   �  (   �  0   �  B     B   _  P   �     �        #   2  #   V  <   z  <   �      �       '   3  =   [  $   �  V   �          ,      L  .   m  4   �     �  /   �  1         R     i  1   �  #   �  &   �  &     4   (  4   ]  4   �  2   �  <   �  J   7   
   �      �      �      �      �      �       �      �       !     >!     W!     P   ;   J          >       ?   I           D   H   -      .   2          :   <   !           F   5   "            7   V           8          4            1      T   *   K       %                    Q                 L   U   )   &           ,      +   
           S   3      C                      G       	                 B   /                  A          #   =   @       $          O      E       6   R       M           (              0   N   9   W       '                  
The following ARM specific disassembler options are supported for use with
the -M switch:
 # <dis error: %08x> # internal disassembler error, unrecognised modifier (%c) # internal error, undefined modifier(%c) $<undefined> %02x		*unknown* (unknown) *unknown operands type: %d* *unknown* <function code %d> <illegal precision> <internal disassembler error> <internal error in opcode table: %s %s>
 <unknown register %d> Address 0x%x is out of bounds.
 Bad case %d (%s) in %s:%d
 Bad immediate expression Bad register in postincrement Bad register in preincrement Bad register name Don't understand %x 
 Hmmmm %x Illegal limm reference in last instruction!
 Internal disassembler error Internal error:  bad sparc-opcode.h: "%s", %#.8lx, %#.8lx
 Internal error: bad sparc-opcode.h: "%s" == "%s"
 Internal error: bad sparc-opcode.h: "%s", %#.8lx, %#.8lx
 Internal: Non-debugged code (test-case missing): %s:%d Label conflicts with `Rx' Label conflicts with register name Small operand was not an immediate number Unknown error %d
 Unrecognised disassembler option: %s
 Unrecognised register name set: %s
 Unrecognized field %d while building insn.
 Unrecognized field %d while decoding insn.
 Unrecognized field %d while getting int operand.
 Unrecognized field %d while getting vma operand.
 Unrecognized field %d while parsing.
 Unrecognized field %d while printing insn.
 Unrecognized field %d while setting int operand.
 Unrecognized field %d while setting vma operand.
 attempt to set y bit when using + or - modifier bad instruction `%.50s' bad instruction `%.50s...' branch operand unaligned branch to odd offset branch value not in range and to an odd offset branch value not in range and to odd offset branch value out of range can't cope with insert %d
 displacement value is not aligned displacement value is not in range and is not aligned displacement value is out of range ignoring least significant bits in branch offset illegal bitmask immediate value is out of range immediate value must be even immediate value not in range and not even index register in load range invalid conditional option invalid register for stack adjustment invalid register operand when updating jump hint unaligned junk at end of line missing mnemonic in syntax string offset not a multiple of 4 offset not between -2048 and 2047 offset not between -8192 and 8191 operand out of range (%ld not between %ld and %ld) operand out of range (%ld not between %ld and %lu) operand out of range (%lu not between %lu and %lu) operand out of range (%lu not between 0 and %lu) syntax error (expected char `%c', found `%c') syntax error (expected char `%c', found end of instruction) undefined unknown unknown	0x%02x unknown	0x%04lx unknown	0x%04x unknown constraint `%c' unknown operand shift: %x
 unknown pop reg: %d
 unrecognized form of instruction unrecognized instruction value out of range Project-Id-Version: opcodes 2.12.91
POT-Creation-Date: 2002-07-23 15:55-0400
PO-Revision-Date: 2002-07-24 08:00-0500
Last-Translator: Michel Robitaille <robitail@IRO.UMontreal.CA>
Language-Team: French <traduc@traduc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
 
Les options sp�cifiques ARM suivantes sont support�es avec l'utilisation de
l'option -M:
 # <erreur du d�sassembleur: %08x> # erreur interne du d�ssassembleur, modificateur non reconnu(%c) # erreur interne, modificateur non d�fini(%c) $<non d�fini> %02x		*inconnu* (inconnu) *type d'op�rande inconnue: %d* *inconnu* <code de fonction %d> <pr�cision ill�gale> <erreur interne du d�sassembleur> <erreur interne dans la table des codes-op: %s %s>
 <registre inconnu %d> Adresse 0x%x est hors gamme.
 Case erron� %d (%s) dans %s:%d
 Expression imm�diate erron�e Registre erron� dans un postincr�ment Registre erron� dans un pr�incr�ment Nom erron� de registre Ne comprend pas %x 
 Hummm %x R�f�rence limite ill�gale dans la derni�re instruction!
 Erreur interne du d�sassembleur Erreur interne:  sparc-opcode.h erron�: � %s �, %#.8lx, %#.8lx
 Erreur interne: sparc-opcode.h erron�: � %s � == � %s �
 Erreur interne: sparc-opcode.h erron�: � %s �, %#.8lx, %#.8lx
 Interne: code qui n'est pas au point (case de test manquant): %s:%d Conflit d'�tiquette avec � Rx � Conflits d'�tiquette avec le nom de registre Petite op�rande n'�tait pas un nombre imm�diat Erreur inconnue %d
 Option du d�sassembleur non reconnue: %s
 Nom de jeu de registres inconnu: %s
 Champ non reconnu %d lors de la construction de insn.
 Champ non reconnu %d lors du d�codage de insn.
 Champ non reconnu %d lors de la prise d'une op�rande int.
 Champ non reconnu %d lors de la prise d'une op�rande vma.
 Champ non reconnu %d lors de l'analyse.
 Champ non reconnu %d lors de l'impression insn.
 Champ non reconnu %d lors de l'initialisation d'une op�rande int.
 Champ non reconnu %d lors de l'initialisation d'une op�rande vma.
 tentative d'initialisation du bit y lorsque le modificateur + ou - a �t� utilis� instruction erron�e � %.50s � instruction erron�e � %.50s... � op�rande de branchement non align�e Branchement avec un d�calage impair valeur de branchement est hors gamme et a un d�calage impair valeur de branchement est hors gamme et a un d�calage impair valeur de branchement hors gamme Ne peut g�rer l'insertion %d
 valeur de d�placement n'est pas align�e La valeur de d�placement est hors gamme et n'est pas align�e. valeur de d�placement est hors gamme Les derniers bits les moins significatifs sont ignor�s dans le d�calage de branchement masque de bits ill�gal valeur imm�diate est hors gamme valeur imm�diate doit �tre paire valeur imm�diate est hors gamme et est impaire registre index n'est pas dans la plage de chargement option conditionnelle invalide registre invalide pour un ajustement de la pile op�rande registre invalide lors de la mise � jour saut indic� non align� rebut � la fin de la ligne mn�monique manquante dans la syntaxe de la cha�ne d�calage n'est pas un multiple de 4 d�calage n'est pas entre -2048 et 2047 d�calage n'est pas entre -8192 et 8191 op�rande hors gamme (%ld n'est pas entre %ld et %ld) op�rande hors gamme (%ld n'est pas entre %ld et %lu) op�rande hors gamme (%lu n'est pas entre %lu et %lu) op�rande hors gamme (%lu n'est pas entre 0 et %lu) erreur de syntaxe (caract�re � %c � attendu,  � %c � obtenu) erreur de syntaxe (caract�re � %c � attendu, fin de l'instruction obtenue) non d�fini inconnu inconnu	0x%02x inconnu	0x%04lx inconnu	0x%04x contrainte inconnue � %c � d�calage d'op�rande inconnu: %x
 registre de pile inconnu: %d
 forme d'instruction non reconnue instruction non reconnue valeur hors gamme 