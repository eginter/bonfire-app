defmodule Iconify.Gis.WorldMap do
  use Phoenix.Component

  def render(assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      aria-hidden="true"
      role="img"
      class={@class}
      viewBox="0 0 100 100"
      aria-hidden="true"
    >
      <path
        fill="currentColor"
        fill-rule="evenodd"
        d="M2.61 5.207a2.5 2.5 0 0 0-2.524 2.5v70.29a2.5 2.5 0 0 0 1.447 2.267L33.2 94.974a2.5 2.5 0 0 0 2.108 0l30.613-14.22l30.613 14.22c1.657.77 3.553-.44 3.553-2.267V22.418a2.5 2.5 0 0 0-1.447-2.268L66.973 5.44a2.5 2.5 0 0 0-2.108 0L34.252 19.66L3.639 5.44a2.5 2.5 0 0 0-1.03-.233Zm64.427 5.775l4.684 2.176c-.155.008-.157.187-.23.276c.26.67.444.296.833.351c.129-.099.009-.242.012-.342l22.75 10.569v64.777l-5.895-2.738c.13-.472.306-.74.41-1.104c.019-.219-.12-.396-.175-.578c-.254-.197-.295-.336-.592-.681c-1.225-.72-1.615-1.563-2.348-2.641c-.407-.303-.553-.55-.912-.854a1.123 1.123 0 0 0-.322-.386c-.751-.312-1.18-.835-1.711-1.354c-.012-.02-.012-.022-.012-.014c-.518-1.174-1.664-1.65-2.513-2.367c.127-.71-.233-.523-.559-.773c-.333.393-.43.145-.848-.04c-.375.018-.641-.05-.804-.054c-.686-.406-.915-.66-1.35-1.129c-.056-.082-.095-.167-.254-.209c-.594.71-.644.341-1.402-.273c.09.008.048.017.014-.022c-.115-.282-.398-.51-.534-.68c-1.047.11-1.137.072-1.765-.808a1.511 1.511 0 0 0-.436-.607c-.829-.194-1.307-.326-1.937-1.07c-1.03.54-1.644-.036-2.502-.509c-.567-.153-.804-.478-1.1-.882a.33.33 0 0 0-.17-.004l-.142-24.838c.02-.008.043-.003.062-.014c.492-.584.159-1.165-.072-1.738l-.006-.895c.007-.004-.002-.001.02-.01c.871-.274 1.366-.698 2.234-.529c.216.512.427 1.047.588 1.625c-.036.57.303.547.615.795c.726.6.61 1.662.812 2.496c.41.684.034.364-.347-.037c-1.017-.138-.481.748-.02 1.44c.28.208.32.507.469.79c.713 1.587 1.381 2.667 2.717 3.6c.848.95 1.01.61 1.56.406c-.264-.578-.642-.861-1.13-1.261c-.428-.24-.687-.415-.819-.55c-.157-.212.208-.142.305-.208c.042.16.09.318.242.41v.002c.101.061.312.194.46.291c.408.267.586.423.85.457c.836-.877.346.102.579.17c.018.04.06.238.06.322c.351.802.653.503 1.238.56a.45.45 0 0 0 .155-.339v-.002a1.113 1.113 0 0 0-.094-.459c.046-.044.048-.012.168-.043c.766-.13.037-.401.705.338c.421.285-.185.04-.31.068h-.006a.322.322 0 0 0-.172.092c-.038.626.247.662.797.955c.762.11.678.28 1.154.65c.046.025.315.23.539.438c.224.208.45.459.479.504c.079.082.008.057.013.092h-.002a.967.967 0 0 0-.137.207c.008.502.348.594.754.82c.108.196.277.32.45.414a.65.65 0 0 0-.192.258c-.045.122-.07.258-.07.4a3.5 3.5 0 0 1-.06.608c-.096-.103-.203-.22-.317-.354c-.341-.455-.294-.657-.207-1.156c-.324-.389-.72-.576-1.154-.869c-.547-.25-.58-.118-1.067.246c-.925-.308-1.38-.083-1.955.244c-.085.337-.472.06-.674.084c-.555-.171-1.034.033-1.35.067c-.085.194-.09.41-.109.793c.029.947.307 1.758.426 2.636c-.08.548.175.85.398 1.233c.82.539 1.968.599 2.854.613c.67.133 1.04.512 1.434.953c.344.724.83 1.228 1.32 1.748c.316.887.825 1.236 1.539 1.664c.14.051-.01.088-.01.094c-.417.348-.229.576-.123 1.045c.269.746.387.676 1.07.615c.369-.446.204-.702.13-1.138c-1.17-.349.084-.415.406-.432c.186-.388.332-.77.525-1.152c.359-.59.44-.888.434-1.627c-.055-2.02-1.592-3.003-1.95-4.752a2.865 2.865 0 0 0-.138-.37c-.224-.231-.283-.562-.409-.835c-.023-.253-.117-.423-.164-.59c.036-.022.075-.03.104-.06c.308.417.663.808 1.037 1.204c.639.628.607-.035.848-.123c-.15-.324-.364-.608-.545-.885c.25.126.508.204.736.153c.25-.154.165.163.25.248c.513.812 1.102 1.195 1.547 1.894c.224.179.394-.07.547-.097c-.337-1.02-1.03-1.747-1.994-2.297c.218-.396-.143-.577-.262-.818c-.32.118-.525.081-.736.033c.613-.004.196-.306.191-.684c-.26-.205-.376.23-.473.29c0 .179.076.3.23.386c-.213-.005-.379-.111-.552-.162c-.654-.499.079-.245.16-.5c.236-.546-.296-.425-.469-.602c-.428.769-.19.487-1.107-.441l-.978-.842c-.661.506-.386-.166-.684-.322c-.689-.701-.762-.423-1.21-.522c-.035.218-.282.104-.358.131c.071-.111.203-.172.277-.234c.317-.114-.023-.435-.035-.653v-.002a1.4 1.4 0 0 0-.147-.312c-.61-.202-1.322-.56-1.982-.854c-.35.088-.307-.342-.461-.513c.069-.05.243-.09.293-.108l.523.02c.075-.025.645.471.88.63c.29.058.392-.187.392-.39l-.11-.926c-.014-.423-.508-.262-.646-.334c.005-.121-.136-.372-.139-.38c.46-.279.262-.363.22-.856a1.208 1.208 0 0 0-.325-.324c-.321-.118.02-.227.031-.371c.105-.517-.223-.718-.433-1.035c-.18-.47-.554.083-.647.097c.006 1.458.223 1.317-.746 2.174c-.044.485-.494.439-.64.545c-.36.344-.574.187-1.11.187c-.442.49-.335.408-.146 1.205c-.274-.43-.66-.906-.963-1.277a.308.308 0 0 0 .148-.107c.106-.353-.044-.726-.117-1.086c-.158-.543-.453-.893-.744-1.305c-.281-.823.225-.07.404.16c-.03.234.241.49.317.637a5.655 5.655 0 0 0 1.11-.178c.373-.125.253-.538.32-.77c-.594-1.377.06-1.582 1.259-1.636c.202.004.377-.005.533-.055c.54.085.35.224.424.762c.086.471.5.023.623.03c.341-.521.12-.936-.037-1.368l-.03-.22c.512-.695.306-1.395.061-2.073a5.173 5.173 0 0 1-.21-.55c.436-.2.65-.004.956.033c-.019.407.004.808.016 1.244l.627.082c.19.024.358.052.525-.07c.367-.477.111-1-.021-1.471v-.002l-.11-.217l.018-.006c.106-.038.2-.09.277-.156c.408-.416.21-.384.97-.117c.256-.035.49-.18.726-.399c.938-1.073.843-1.168.724.297a4.67 4.67 0 0 0-.412 1.168c.05 1.323-.143.25-.539.635c-.395.455-.944.185-1.467.238c-.487.108-.385.492-.529.729c.213.198.283.5.412.867c.747-.27 1.567-.173 2.506-.09c.358-.044.385-.444.516-.643c.063-.381.168-1.317.173-1.373c.498-.07.885-.238 1.227-.39c.132-.03.22-.114.31-.198c.065.037.13.077.192.082c.57.163.284-.55.324-.628a.403.403 0 0 0-.357-.102c-1.045.311-.94.018-1.518-.406c-.442-.654.382-.692.494-.9c-.064-.845-.27-1.81-.353-2.544c-.292-.698-1.173-.847-1.733-1.273c.524-.309.93-.597 1.413-.94c.5.21 1.076.474 1.675.706c.002.117.047.26.14.351c.33.268.817.322 1.183.424a.39.39 0 0 0 .255-.225c-.237-.544.116-.403.358-.802c.217-.028.15.182.19.228c.333.678-.059.61-.218 1.006c-.68.514-.562.673-.802 1.289c-.01.368.03.852.117 1.408c.119.796.051.389-.205 1.07c.14.452.5.137.756.167c.313-.44.605-.476.937-.725c-.005-.401.237-.275.412-.479c.052-.325.246-.48.377-.744c.098-.27-.013-.536-.029-.785c.955-.77.563-.349 1.25-.152c.672.18 1.43-.246 2.082-.225c.235.43.544-.055.697-.07c.1-.24.04-.462-.049-.8c-.421-.51.372-.46.393-.485c.448.284.596.792.941 1.224c.503.096.157.27.303.52c.094.292.304.412.475.63c.531.544.421-.28.547-.365c.024-.516-.327-.492-.608-.709c.129-.4.325-.462.545-.812c-.01-.852-.592-1.356-1.183-1.922c-.936-1.52-1.986-2.712-3.387-3.648c-2.512-.529-2.228-1.941-3.979-2.8c-.875-.492-1.124-1.303-1.707-1.97c-1.48-.55-1.775-3.797-.423-2.01c.733.655.745.341 1.167-.101a8.114 8.114 0 0 0-.738-.924a2.945 2.945 0 0 0-.531-.39c-.648-.653-1.316-1.293-2.059-1.702c-.813-.054-.693.117-1.072.512c.24.801.772 1.475 1.147 1.973c-.047.743-.186 1.374-.334 1.957c-1.45-1.013-1.795-1.235-2.354-3.059c-.18-.107-.315-.275-.467-.408c-.7-.649-.59-.277-.974.129c-.61-.102-.32-.344-.493-.535c-.32-.531-.827-.695-1.285-.92c-.083-.008-.073-.017-.06-.004c-.853-.875-.178-.997.1-1.938c-.071-.838-.536-1.593-1.231-1.953c-.29-.149-.502-.52-.664-.713v-.002c-.239-1.16-.765-1.334-1.621-.758c-.196.437-.403.48-.672.737c-.177-.036-.267-.137-.406-.21c-.8-.57-1.79-.392-2.676-.25c-.544.883-.138 1.055-1.278.743zm-2.998.354l.004.51c-1.124 1.034-2.344 2.236-3.072 3.316c-.67 1.136-.859 2.446-1.182 3.463c-.045.248-.141.455-.23.713c.118.483.58.646.875.97c.683-.22.764-.064 1.257.18c-.348.11-.628.434-.86.649l-.003-.004c-.49-.225-.547.04-.906.36c-.012.02-.026.037-.04.058c.008-.276-.314-.285-.44-.4h-.003a.407.407 0 0 0-.25.017c-.617.584-.433.76-.142 1.324c-.063.086-.126.17-.18.25c-.404-.637-.882-.242-1.336-.03c.056.357.074.542.188.956c.26.213-.073.378-.088.459c0-.033.04-.067.037-.1a.814.814 0 0 0-.643-.71a4.055 4.055 0 0 1-.62-.22c-.55-.002-.764-.193-1.184-.314c-.135.121-.137-.13-.243-.23c-.214-.24-.582-.15-.796-.19c-.473.17-.719.369-1.092.598c-.186.554-.844.882-1.242 1.426c-1.135 1.733-1.468 3.14-2.248 4.728c-.326.626-.781 1.256-1.133 1.807c-.535.869-.267 1.89.052 2.687a.446.446 0 0 0 .252.116c.39-.319.191.701.293 1.103c.061.247-.231.333-.312.45c-.874 1.146-.84 1.318-1.795-.073c.171-.801-.222-.965-.586-1.3c-.742.35-.797.997-.893 1.681c.317.334-.18.353-.277.545c-.27.159-.28.482-.39.693c-.417.23-.287.53-.311.9c.055.132-.063.176-.11.303c-.172.33.229.469.305.625c.35.012.61-.313.803-.449c.16-.13.176-.26.27-.385c.108.158-.08.255-.17.538c-.065.078-.025.17-.037.252c.498.22.108.297.255.714c.086.341.445.137.606.186c.252.185.171.534.213.824l-.655.258c-.42.112-.767.406-1.074.61c-.195.258-.202.599-.195 1.2c.008.707-.011 1.026.064 1.276c.016.42.474.144.618.187c-.386.801-.813 1.477-1.038 2.366c-.288.74-.596.385-1.306.777c-.148.326-.112.573-.057.812c.203.08.299-.027.485-.052c-.496.644-.59 1.396-.598 2.117c.122.476.085.76-.152 1.168a.79.79 0 0 0-.123.303a.332.332 0 0 0 .037.216c.028.05.075.085.123.112l-.004-.016c-.002-.002.007.035.09.053a.351.351 0 0 1-.086-.037c.003.009.006.016.006.029c0 .185.088.282.18.385c.805.777 1.472 1.178 2.572 1.158c.11-.06.504-.266.869-.455c.39-.203.877-.533 1.146-.783c.292-.272.51-.423.627-.467c.19-.03.376.168.524.234c.163.006.286-.066.416-.152c.196-.193.087.077.127.111l-.075.467c-.36.348.047.454.078.764c.085.103.193.206.315.296c.338.253.521.564.57.952c.02.16.067.37.117.521a.45.45 0 0 1-.062.299c-.2.347-.336.828-.402 1.252a2.58 2.58 0 0 0-.038.574c-.044.277.263.407.325.502c.038.05.088.137.138.248c.1.223.199.546.268.91c.042.222.1.437.158.612c.13.353.357.62.559.91c.117.366.23.75.312 1.06c.156.15.41.202.63.106c.322-.141.778-.42 1.202-.711c.885-.488 1.323-1.35 1.742-2.145c.31-.774.592-1.521 1.008-2.187c.173-.38.229-.856.073-1.246c.116-.55.7-1.088 1.019-1.45c.499-.769.299-1.636.133-2.406c-.182-.827.216-1.521.451-2.03c.858-1.196 1.63-2.494 2.152-3.8c.377-1.203.124-.914-.51-1.117c1.002-.814 1.855-1.966 2.505-3.043c.191-.3.3-.569.251-.84c-.146-.648-.524-.339.399-.705c.48-.457.842-.189 1.18-.182c.138.163.324.3.474.438l.17 30.103c-.28.109-.468.258-.879.416c-1.06.514-1.532.502-2.28.137c-1.006-.07-1.52.632-1.886 1.338c-.787.622-1.572 1.33-2.25 2.266c-.376.896-1.152.902-1.935 1.027c.076.329-.34.307-.52.47c-1.083 1.264-1.89 1.67-3.441 1.846c-.327-.22-.498.223-.664.307c-.352.622-.944.781-1.541 1.072c-.698.6-1.026.302-1.545.05c-.626.125-.744.737-.946 1.226c-1.096.79-1.816 1.246-2.478 2.449a1.291 1.291 0 0 1-.133.246c-.417.359-.942.97-1.377 1.41c-.249.945-.595 1.346-.969 1.906c-.113.168-.229.36-.31.522l-.088.174l-5.399 2.508c-.033-1.732-.092-11.723-.152-23.266c.332-.302.745-.74 1.074-1.043c.374-.24.577-.487.784-.945c.438-1.221.485-2.344 1-3.354c.221-.398.352-.645.43-.87c.076-.226.085-.428.07-.651c-.217-.826-.693-.634-1.457-.74c-.651.18-1.298.174-1.936.058c-.034-6.995-.07-14.322-.094-19.973c.394-.226.626.037.858.069c.923-.169.939-.812 1.07-1.617c.15-.79.506-1.72.853-2.499c.544-.366.99-.974 1.243-1.668c.18-.59.665-.912 1.05-1.24c.335-.276.746-.738 1.09-1.181c.388-.334.492-.866.617-1.221c.418-.347.076-1.624.06-1.979c-.101-.603.27-.924.327-1.543h.004c.037-1.56.7-2.789.547-4.101c-.325-.114-.12-.24-.19-.381l7.336-3.408c.029.06.079.11.11.152c1.087 1.21 1.095.869 1.51-.418c.518-.736 1.347-.244 1.726-1.289zm-58.953.289l12.68 5.889c-.458.283-.727.756-.995 1.185c.443.52.75.828 1.114 1.334c.246.018.173.223.254.326c.496.863 1.134 1.46 1.949 1.659c.749.069 1.07.216 1.717.45c.655-.544.127.074.507.294c.385.257.825.555 1.16.808c.146.244.195.356.307.465c-.372-.195-1.163-.367-1.56-.435c-.032.227-.19.65-.42.546c-.024-.125.06-.37.09-.546c.047-.326-.354-.42-.514-.579c-.36-.092-.827.1-1.023.163c-.77-.231-.94-.699-1.31-1.329c-.273-.552-.69-.874-1.118-1.23a1.262 1.262 0 0 0-.334-.352c-.652-.549-.806-.188-1.26-.101c.046 1.082-.339 1.852.074 2.76c.263.802.41.776 1.094.798c.631.142.546.917.635 1.315h-.045a5.427 5.427 0 0 0-.506-.475c-.237-.106-.435-.312-.582-.418c-.389-.391-.632-.65-.928-.982c-.441-.15-.992-.1-1.513-.053c-.368.082-.575.092-.678.06c-1.103-1.396-3.065-2.516-4.045-3.556c-.843-.959-1.327-.716-2.238-.69c-.696.657-.841.631-1.534.893c.29.945.267 1.277-.19 2.035c.183.884.541 1.206 1.124 1.682c.362.176-.169.141-.287.24c-.514.537-.629.883-.844 1.444c.039.436.435.477.654.638c.923.421.902.99 1.493 1.506c-.184.327-1.546.622-2.14.967c.047.54.37.299.69.418c.196-.243.485-.06.706-.086c1.052.207 1.747-.535 1.673.477c.597-.109.912-.497 1.237-.848c.205-.994 1.65.145 1.949.39c.207.106.458.34.8.801c.762.728 1.085 1.435 1.56 2.221c.292.29-.119.399-.198.666c.016.672.362 1.054.686 1.492c.73-.021.442.218.482.727c.281.61.688 1.23.932 1.677c.028.228.038.616.045 1.293c-.119 2.186.834 3.565 1.888 5.348c.43.414.306.982.362 1.277c.519.794.904 1.718 1.543 2.428c.85.28 1.092 1.632 2.119 2.71c.665.67.983.946 1.332 1.052c.225.068.306.132.535.453h.002c.196.276.559.662.853.914c.74 1.065 1.414 1.995 2.356 2.889c.644.632.538.712-.051 1.318c-.05.112-.159.198-.236.295c.031.466-.072.91-.155 1.31c.115.442.325.836.508 1.19c.575 1.454 1.077 2.515 1.926 3.535c.566 1.926-.257 4.345-.611 6.336c.042.867-.197 1.641-.266 2.006a.486.486 0 0 0-.133.36c.545.77.235 1.586.56 3.03c.38.371.377.737.532 1.092c.293.377.791.554 1.184.76c.398.361.58-.014.834-.04c-.141-.476-.487-.889-.733-1.36c-.263-.347-.025-.789-.027-.938c.124-.224.377-.501.642-.826c-.515-.952-.026-.993.463-1.527c-.081-.459.142-.296.291-.608c-.002-.392.31-.098.471-.15l.06 10.5c-.075.008-.151.004-.222.018c-.928.258-1.418.842-2.016 1.42c.068.931.183 1.205-.642.63c-.734.215-.99.569-1.332.975c-.142.148.062.298.084.4c-.49.882-1.382.44-2.13-.074c-.818-.638-1.427-.911-2.261-1.234c-.03-.028-.06-.095-.127-.309c-.426-.7-.843-.763-1.799-1.05c-.318-.134-.431.246-.597.341c-.259.698.113.892.332 1.33c-.016.16-.077.289-.2.332c-.016-.488-.332-.409-.615-.617c-.186-.01-.362.01-.517.014c-.821-1.034-2.155-1.645-2.934-2.323L16.5 79.715l-.38.334h-.003c-1.123-.147-2.46-.124-3.064.053L5.086 76.4Zm58.967 1.945l.023 3.992l-.043-.002c-.66.015-.507-.029-.785.655c.152.392.072.752.107 1.146c.021.089.105.156.182.221c-.29-.089-.633-.15-.937-.12c-.814.136-1.08-.312-1.4-.712c.407-2.158 1.406-3.733 2.853-5.18zm-43.614 5.188c.589.27.536.395.715.986c.047.55.566.122.668.145c-.01-.15.081-.29.121-.434c.65.325 1.273.89 1.639 1.197c-.413-.015-.282.036-.58.075a.291.291 0 0 0-.147.043c-.386-.126-.602-.306-.89-.43c-.164-.418-.501-.006-.643-.008a.503.503 0 0 0-.054.258c.157.17.22.409.244.658c.484.192.013.147.015.172c-.002-.057-.01-.115-.015-.172c-.001-.001-.003 0-.004-.002a1.008 1.008 0 0 1-.242-.59c-.002-.023.002-.044.002-.066a.623.623 0 0 0-.174-.14c-.06-.031-.074-.047-.082-.054c-.008.034.003.063-.012.098a.261.261 0 0 0-.01-.111a.225.225 0 0 1 .022.013a.48.48 0 0 0-.104-.435v-.002c.005.005.008-.07-.017-.012c-.162-.92-.657-.451-1.067-.244c-.373-.693.05-.738.615-.945zm4.206 1.953l.601.28c-.117.23.093.483.135.702c-.014.059-.167.187-.25.28c-.116-.163-.245-.321-.443-.368c-.066-.015-.124-.055-.196-.218c-.683-.453.037-.155.123-.512c.021-.05.025-.107.03-.164zm4.23 1.965l.61.283c.407.709.242.721.15 1.352c.543.964.597 1.553 1.494 2.203c.625-.062.83.094 1.248.543l.074 12.908c-.18-.63-.395-1.252-.67-1.912c-.985-.985-.815.894-1.273-.719c-.06-.12.125-.237.187-.355c.1.078.147.127.268.167c.743-1.022.939-1.485 1.445-2.628c-.047-.254-.197-.488-.449-.872a4.64 4.64 0 0 1-.272-.462c.048-.282-.27-.328-.376-.457c-.446-.484-.174-.728-.288-1.364c-.331-.825-.937-1.627-1.4-2.297c-.497-.458-.742-1.258-.996-1.847c-.191-.345-.535-.66-.904-.906c-.513-.09-.974-.5-1.186-.616c-.304-.372-1.297-.203-1.3-.203c-.032-.2-.002-.533.091-.556a31.409 31.409 0 0 0 1.635.834c.45.362.536.01.857-.038c.1-.64.15-.834-.18-1.462c.085-.004.152.02.25.003c.16-.027.302-.066.419-.181c-.14-.815.173-.886.36-1.315a.417.417 0 0 0 .206-.103zm23.305 6.607c.06-.035-.075.502-.028 1.131c-.006.275.335.263.465.365c.008.046-.286.62-.367.768c-.008.1-.06.191-.09.287c-.596-.077-.028-.24-.068-.58c.016-.275-.053-.574-.278-.781c-.07-.065-.1-.154-.03-.407c.255-.535.36-.762.396-.783zm39.443.639c-.725.162-.412.6-.502.85c.938.583.93.018 1.225-.27c-.29-.44-.509-.6-.723-.58zm-64.252.193l.006.002c.123.063.241.11.35.137c.175-.07.168.109.242.156c.078.187.128.464.123.5c-.044.67-.144.988.34 1.565c.161.132.367-.009.494-.012c.258.232-.331.636-.36.674c-.487-.415-.485.088-.767.215c.024.092-.107.158-.16.238a1.223 1.223 0 0 1-.131-.193c-.107-.38-.333-.61-.678-1.088c.633-.217.617-.815.711-1.309c.008-.445-.071-.661-.17-.885zm16.115.668c-.398.169-.654.338-1.002.58c-.387.383-.496.138-.916.18c-.461.305-.52.772-.668 1.21c.26.355.458.784.692 1.183c.361-.16.755-.19 1.13-.225a.643.643 0 0 0 .356-.34c.34-.369.696-.836.99-1.256c.268-.75-.086-.912-.582-1.332zm8.366 2.479l-.014.023c-.149-.014-.302.031-.44.045c.04-.101.066-.276.096-.424c.196.08.427-.164.535-.206c.039.044-.076.362-.177.562zm-26.395-.145c.075-.031.163.082.447.596c1.041.297.2.305.405.723c.363.597.522.366 1.039.117c.156-.536.289.055.375.072c-.743-.05-.148.104-.54.379c-.032.607.348.417.59.613c.114-.183.041.158.055.213c.099.584-.124.576-.3.965c.249.505.39.916.533 1.523c-.277.075-.398.347-.57.5l-.13-.072c.122-.371-.155-.544-.24-.799c-.62-.363-1.037-.866-1.348-1.265c-.47-.297-.748-.809-1.007-1.121c-.048-.304-.16-.572-.375-.743c-.26-.718.191-1.009.693-1.425c.236-.067.298-.244.373-.276zm34.344 2.1c-.03.267.16.495.224.697c.101.136.05.276.075.42c-.087.048-.17.102-.25.17c-.012.007-.206-.066-.286-.092c.083-.295.19-.315.29-.482c.114-.277-.226-.453-.313-.627c-.337-.234-.3-.572-.422-.885c.222-.393.552.612.682.799zm-30.91-.559c.127.136.267.375.402.72c.211.286-.264-.172-.346-.226a6.138 6.138 0 0 1-.49-.295c.003-.004.01 0 .014-.005c-.26-.956.102-.048.42-.194zm27.408 1.34c.142-.001.351.053.642.19c-.112.348-1.066.416-1.42.462c-.373.312-.755.801-1.095.828c.11-.477.349-.914.576-1.378c.401.472.53.164.95.054c.12-.116.206-.155.347-.156zm31.705 2.088a.34.34 0 0 0-.244.184c-.062.473.308.664.508.914c.513.205.227-.474.306-.64c.08-.319-.418-.342-.57-.458zm-34.211 1.71c.354.177.719-.017 1.023-.089c1.054-.6.91-.166.52.693c-.97.427-2.247.753-3.176 1.067c-.322 1.087-.891.766-1.816.74c-.077.035-.132.027-.2.031c.013-.042.045-.081.053-.125c.023-.119.032-.245.03-.367c.057-.637-.344-.402-.57-.59c.248-.311.207-.685.24-1.035c.974-.564.523.23.562.276c-.703.545-.34.547.043.978c.204.02.394-.002.555-.096c.247-.323.285-.449.464-.808c.506-1.372.748.128 1.786-.553c-.115-1.166.308-.077.486-.121zm-4.772 1.315c.048.114.185.173.297.184c-.033.016-.06.026-.095.045c-.604.31-1.139.668-1.682 1.025c-.089.063-.129.108-.203.164c-.044-.83.444-.529.59-.677c.588-.204.326-.462.416-.809c-.267-.912.102-.572.554-.988c.215-.274.1.766.123 1.056zm-40.94-1.076c-.572.373-.101.597.028.727c.281.359.494.746.696 1.136c.468.522.524-.057.771-.119c.01-.152-.108-.257-.158-.375c-.229-.424-.613-.762-.912-1.064c-.148-.114-.294-.21-.426-.305Zm81.616 0c-.45-.066-.17.463-.209.567c.091.18.313.154.444.218c.784-.026.043-.586.047-.713a.562.562 0 0 0-.282-.072zm.836 1.252c-.036.1-.017.26.069.35c.793.206.407-.135.601-.508c-.254-.347-.537.127-.67.158zm1.42.408c-.303.69.146.661.485.877c.387-.094.732.13 1.16.256c.406-.19-.077-.585-.09-.687c-.423-.185-.743-.238-1.047-.295c-.15-.14-.36-.107-.508-.15zm-65.207.41c.067.019.112.111.154.153a.975.975 0 0 1 .211.582c0 .184-.012.33-.027.322c-.015-.008-.11-.272-.211-.586c-.1-.311-.144-.451-.127-.47zm.572.329a.49.49 0 0 1 .178.212c.038.086.02.129-.04.098a.48.48 0 0 1-.179-.209c-.037-.086-.02-.132.041-.101zm29.38.986c.012-.054.172.14.208.137c.234.19.307.497.44.74c-.043-.004-.082-.023-.127-.018c-.02-.145-.338-.448-.457-.603c-.017-.088-.043-.169-.065-.256zm-24.305.04l.078.007l.004.629c-.266.309-.441-.085-.71-.219a.534.534 0 0 1-.025-.293c.038.025.066.072.104.092c.248.312.45-.134.556-.166c.001-.023-.005-.032-.007-.049zm-1.952 1.436c.112.017.216.015.313.004c.157.648.412.482.912.508c.276.028.571-.033.816-.049l.061 10.649c-.015-.023-.021-.027-.037-.05c-.281-.426-.503-.612-1.057-.888c-.415-.187-.773-.518-1.105-.78c-.466-.412-.98-.588-1.903-.42c-.229-.058-.68-.315-.943-.427c-.095 0-.193-.061-.295-.263c-.102-.202-.174-.523-.174-.908c0-.364-.013-.628-.166-.86c-1.002-.67-.868-.358-.736-1.299c.015-.275.198-.006.357-.011c.54.273.985.704 1.43 1.119a.342.342 0 0 0-.219.195c-.1.381.287.493.47.691c.21.052.364.137.536.202c.317.079.54.333.703.435c.798.092.85.371 1.409.692c.717-.21.512-.13.22-.768c-.358-.008-.347-.287-.576-.482c-.183-.313-.511-.392-.744-.551c-.312.033-.227-.48-.252-.733c.065-.371-.414-.366-.541-.478h-.002a.331.331 0 0 0-.223.119c-.1.212-.295-.235-.427-.34c.422-.439.191-.755.138-1.18c-.106-.292-.404-.174-.568-.246c-.084-.418-.164-.806-.252-1.248c.904-.425 1.232-.83 1.55-1.584c.464-.716.043-.177.817-.316c.749.028.25-.314.291-.67c-.02-.018-.01-.013-.01-.004c0 .01-.004.008.006-.004c.02-.024.094-.07.201-.054zm-6.32 1.762a.79.79 0 0 1 .244.139c.717.529 1.375.474 2.098.982c.118.285.221.702.322 1.02l-.12.467c-.575.326-.996-.148-1.647-.291c-.202.07-.284.231-.334.414c-1.142-.82-1.287-2.004-.563-2.73zm53.084 1.725c.14.242-.195.333-.283.484c-.16-.223-.322-.445-.483-.668c.824-.649.35.063.766.184zm-18.082 2.336c-.207.261-.378.531-.53.746c-.206-.308-.552-.24-.825-.315c-.343.357-.027.55-.026.77c.265.078.532-.085.735-.117c-.292.274-.505.644-.704.943c-.017.513-.09.716-.132 1.166c-.26 1.82.586 1.94 1.47.762c.086-.227.163-.527.266-.987c.139-.619.305-1.296.35-1.439c.26-1.071-.015-1.136-.604-1.53zm16.863 1.48c.18 1.32 3.26 2.551 2.65.98a.657.657 0 0 0-.294-.085c-.876-.118-2.116-1.084-2.356-.895zm-15.132.168a.357.357 0 0 0-.157.031c-.631.613.13.486.213.698c.641-.263-.048-.623-.056-.729zm27.171.725a.323.323 0 0 0-.074.205c.115.174.112.356.139.441c-.058.55.383.535.62.698a.315.315 0 0 0 .151-.147c.046-.432-.252-.913-.375-1.246c-.177-.194-.321.034-.46.049zm1.196 1.111c-.162.086-.164.221-.164.315c-.122.466.438.384.55.476c.278-.093.085-.374.116-.51c0-.362-.372-.208-.502-.28zm-1.899 7.373c.166.458.467.77.764 1.131c.451.513.443-.329.531-.395c-.204-.391-.49-.718-.754-1.062c-.327-.466-.378.228-.54.326zm2.201 5.283c-.007.294.142.585.217.827c.313 1.162-.113.951-.978 1.63c-.648.146-.606.51-.805.899c.342.166.147.388.219.58c.347.524.72.302 1.273.182c-.022-.496.41-.378.559-.516a.323.323 0 0 0 .15-.078c-.12-.395.36-.4.446-.496c.625-.453.741-.658.851-1.36c-.059-.134-.138-.177-.22-.226c-.397-.14-.524-.52-.708-.881c-.506-1.258-.576-.489-1.004-.56z"
        color="currentColor"
      />
    </svg>
    """
  end
end
